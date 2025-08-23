const env = require('../config/env');
const { metrics } = require('../instrumentation/metrics');

// Mémoire locale : { key -> { fails, firstAt, banUntil? } }
const store = new Map();
const now = () => Date.now();

const keyFrom = (req) => {
    const ip = req.ip || req.connection?.remoteAddress || 'unknown';
    const email = (req.body?.email || '').toLowerCase().trim();
    return `${ip}:${email}`;
}

const getEntry = (key) => {
    const e = store.get(key);
    if (!e) return null;
    if (now() - e.firstAt > env.loginBruteWindowMs) { store.delete(key); return null; } // fenêtre expirée
    return e;
}

const setFail = (key) => {
    const e = getEntry(key) || { fails: 0, firstAt: now() };
    e.fails += 1;
    // bannissement optionnel (durcissement) : au-delà d’un multiple de threshold
    if (env.loginBruteBanMs > 0 && e.fails >= env.loginBruteTreshold * 4) {
        e.banUntil = now() + env.loginBruteBanMs;
    }
    store.set(key, e);
}

const clearKey = (key) => { store.delete(key); }

const computeDelay = (fails) => {
    if (fails < env.loginBruteTreshold) return 0;
    const steps = fails - env.loginBruteTreshold + 1; // 5->1, 6->2, ...
    return Math.min(env.loginBruteBaseDelayMs * Math.pow(2, steps - 1), env.loginBruteMaxDelayMs);
}

const loginBruteforce = (req, res, next) => {
    // Clé basée sur IP + email
    const key = keyFrom(req);
    const e = getEntry(key);

    // Si banni temporairement
    if (e?.banUntil && now() < e.banUntil) {
        const retrySec = Math.ceil((e.banUntil - now()) / 1000);
        res.set('Retry-After', String(retrySec));
        return next({ status: 429, type: 'too_many_requests', message: 'Try again later' });
    }

    const delay = e ? computeDelay(e.fails) : 0;

    // On retarde le traitement (tarpit), puis on observe le résultat pour incrémenter/clear
    const proceed = () => {
        res.on('finish', () => {
            const status = res.statusCode;
            // Considère comme échec tout code >= 400
            if (status >= 400) {
                setFail(key);
            } else {
                clearKey(key);
            }
        });
        next();
    };

    if (delay > 0) {
        res.set('X-Bruteforce-Delay', String(delay));
        metrics.loginTarpitDelay.observe(delay);
        setTimeout(proceed, delay);
    } else {
        proceed();
    }
};

// important, petit GC pour éviter un Map trop gros sur long run
setInterval(() => {
    const t = now();
    for (const [k, v] of store.entries()) {
        if (t - v.firstAt > env.loginBruteWindowMs) store.delete(k);
    }
}, Math.max(30000, Math.floor(env.loginBruteWindowMs / 3))).unref?.();

module.exports = { loginBruteforce };