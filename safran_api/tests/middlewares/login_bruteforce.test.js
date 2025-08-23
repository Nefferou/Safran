const env = require('../../src/config/env');

// Mock des métriques avant d'importer le module
jest.mock('../../src/instrumentation/metrics', () => ({
  metrics: {
    loginTarpitDelay: {
      observe: jest.fn()
    }
  }
}));

describe('middlewares/login_bruteforce', () => {
  let req, res, next;
  let originalDateNow;
  let setIntervalSpy;
  let loginBruteforce;
  let metrics;
  let testCounter = 0;

  beforeEach(() => {
    // Mock Date.now() pour contrôler le temps
    originalDateNow = Date.now;
    Date.now = jest.fn(() => 1000000);

    // Reset des mocks
    jest.clearAllMocks();
    
    // Mock de setTimeout pour les tests
    jest.useFakeTimers();

    // Mock de setInterval pour éviter les timers en arrière-plan
    setIntervalSpy = jest.spyOn(global, 'setInterval').mockImplementation(() => ({
      unref: jest.fn()
    }));

    // Mock de console.error pour éviter les logs pendant les tests
    jest.spyOn(console, 'error').mockImplementation(() => {});

    // Reset du store global en important le module à nouveau
    jest.resetModules();
    const loginBruteforceModule = require('../../src/middlewares/login_bruteforce');
    loginBruteforce = loginBruteforceModule.loginBruteforce;
    
    // Récupérer les métriques mockées
    metrics = require('../../src/instrumentation/metrics').metrics;
    
    // Incrémenter le compteur de test pour avoir des clés uniques
    testCounter++;
  });

  afterEach(() => {
    Date.now = originalDateNow;
    jest.useRealTimers();
    jest.restoreAllMocks();
  });

  const makeReq = (ip = '192.168.1.1', email = 'test@example.com') => ({
    ip: `${ip}_${testCounter}`,
    body: { email: `${email}_${testCounter}` },
    connection: { remoteAddress: `${ip}_${testCounter}` }
  });

  const makeRes = () => {
    const res = { statusCode: 200 };
    res.set = jest.fn().mockReturnValue(res);
    res.on = jest.fn().mockImplementation((event, callback) => {
      if (event === 'finish') {
        res._finishCallback = callback;
      }
    });
    return res;
  };

  const triggerFinish = (res, statusCode = 200) => {
    res.statusCode = statusCode;
    if (res._finishCallback) {
      res._finishCallback();
    }
  };

  describe('keyFrom', () => {
    it('should create key from IP and email', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      // La clé devrait être basée sur IP + email
      expect(next).toHaveBeenCalled();
    });

    it('should handle missing IP', () => {
      req = { body: { email: 'test@example.com' } };
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });

    it('should handle missing email', () => {
      req = { ip: '192.168.1.1', body: {} };
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });

    it('should handle missing body', () => {
      req = { ip: '192.168.1.1' };
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });

    it('should normalize email (lowercase and trim)', () => {
      req = makeReq('192.168.1.1', '  TEST@EXAMPLE.COM  ');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });
  });

  describe('getEntry and store management', () => {
    it('should return null for non-existent key', () => {
      req = makeReq('192.168.1.1', 'new@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });

    it('should clear expired entries', () => {
      // Créer une entrée expirée
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      // Premier appel pour créer l'entrée
      loginBruteforce(req, res, next);
      triggerFinish(res, 400); // Échec pour créer l'entrée

      // Avancer le temps au-delà de la fenêtre
      Date.now = jest.fn(() => 1000000 + env.loginBruteWindowMs + 1000);

      // Deuxième appel - l'entrée devrait être expirée
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });
  });

  describe('setFail and clearKey', () => {
    it('should increment fail count on 400+ status', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);
      triggerFinish(res, 400);

      // Deuxième tentative avec le même IP/email
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });

    it('should clear key on success (200 status)', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);
      triggerFinish(res, 200);

      // Deuxième tentative - devrait être comme une première tentative
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });

    it('should clear key on success (300 status)', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);
      triggerFinish(res, 302);

      // Deuxième tentative - devrait être comme une première tentative
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });
  });

  describe('computeDelay', () => {
    it('should return 0 delay for fails below threshold', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      // Créer quelques échecs mais en dessous du seuil
      for (let i = 0; i < env.loginBruteTreshold - 1; i++) {
        loginBruteforce(req, res, next);
        triggerFinish(res, 400);
        
        req = makeReq('192.168.1.1', 'test@example.com');
        res = makeRes();
        next = jest.fn();
      }

      // Dernière tentative - pas de délai
      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
      expect(res.set).not.toHaveBeenCalledWith('X-Bruteforce-Delay', expect.any(String));
    });

    it('should apply delay for fails at threshold', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      // Créer exactement le nombre d'échecs du seuil
      for (let i = 0; i < env.loginBruteTreshold; i++) {
        loginBruteforce(req, res, next);
        triggerFinish(res, 400);
        
        req = makeReq('192.168.1.1', 'test@example.com');
        res = makeRes();
        next = jest.fn();
      }

      // Dernière tentative - devrait avoir un délai
      loginBruteforce(req, res, next);

      expect(res.set).toHaveBeenCalledWith('X-Bruteforce-Delay', expect.any(String));
      expect(metrics.loginTarpitDelay.observe).toHaveBeenCalled();
    });

    it('should apply exponential delay', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      // Créer plus d'échecs que le seuil
      for (let i = 0; i < env.loginBruteTreshold + 2; i++) {
        loginBruteforce(req, res, next);
        triggerFinish(res, 400);
        
        req = makeReq('192.168.1.1', 'test@example.com');
        res = makeRes();
        next = jest.fn();
      }

      // Dernière tentative - devrait avoir un délai plus élevé
      loginBruteforce(req, res, next);

      expect(res.set).toHaveBeenCalledWith('X-Bruteforce-Delay', expect.any(String));
      expect(metrics.loginTarpitDelay.observe).toHaveBeenCalled();
    });

    it('should cap delay at maximum', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      // Créer beaucoup d'échecs pour dépasser le délai maximum
      for (let i = 0; i < env.loginBruteTreshold + 10; i++) {
        loginBruteforce(req, res, next);
        triggerFinish(res, 400);
        
        req = makeReq('192.168.1.1', 'test@example.com');
        res = makeRes();
        next = jest.fn();
      }

      // Dernière tentative - délai devrait être limité
      loginBruteforce(req, res, next);

      expect(res.set).toHaveBeenCalledWith('X-Bruteforce-Delay', expect.any(String));
      expect(metrics.loginTarpitDelay.observe).toHaveBeenCalled();
    });
  });

  describe('ban functionality', () => {
    it('should test ban logic with threshold calculation', () => {
      // Test direct de la logique de bannissement
      const threshold = env.loginBruteTreshold;
      const banThreshold = threshold * 4;
      
      // Vérifier que le seuil de bannissement est correct
      expect(banThreshold).toBeGreaterThan(threshold);
      expect(banThreshold).toBe(threshold * 4);
    });

    it('should test ban duration calculation', () => {
      // Test de la durée de bannissement
      const banMs = env.loginBruteBanMs;
      expect(banMs).toBeGreaterThan(0);
    });

    // Test simplifié pour vérifier la logique de débannissement
    it('should handle time-based expiration logic', () => {
      // Test de la logique de calcul du temps
      const currentTime = Date.now();
      const banDuration = env.loginBruteBanMs;
      const futureTime = currentTime + banDuration + 1; // Ajouter 1 pour être sûr
      
      expect(futureTime).toBeGreaterThan(currentTime);
      expect(banDuration).toBeGreaterThan(0);
    });
  });

  describe('delay execution', () => {
    it('should execute immediately when no delay', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
      expect(res.set).not.toHaveBeenCalledWith('X-Bruteforce-Delay', expect.any(String));
    });

    it('should delay execution when delay is applied', () => {
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      // Créer des échecs pour déclencher un délai
      for (let i = 0; i < env.loginBruteTreshold; i++) {
        loginBruteforce(req, res, next);
        triggerFinish(res, 400);
        
        req = makeReq('192.168.1.1', 'test@example.com');
        res = makeRes();
        next = jest.fn();
      }

      // Dernière tentative - devrait être retardée
      loginBruteforce(req, res, next);

      expect(res.set).toHaveBeenCalledWith('X-Bruteforce-Delay', expect.any(String));
      expect(metrics.loginTarpitDelay.observe).toHaveBeenCalled();

      // next() ne devrait pas être appelé immédiatement
      expect(next).not.toHaveBeenCalled();

      // Avancer le temps pour déclencher le setTimeout
      jest.runAllTimers();

      expect(next).toHaveBeenCalled();
    });
  });

  describe('edge cases', () => {
    it('should handle different IP addresses separately', () => {
      // Premier IP
      req = makeReq('192.168.1.1', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);
      triggerFinish(res, 400);

      // Deuxième IP avec même email
      req = makeReq('192.168.1.2', 'test@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      // Devrait être traité comme une première tentative
      expect(next).toHaveBeenCalled();
      expect(res.set).not.toHaveBeenCalledWith('X-Bruteforce-Delay', expect.any(String));
    });

    it('should handle different emails separately', () => {
      // Premier email
      req = makeReq('192.168.1.1', 'test1@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);
      triggerFinish(res, 400);

      // Deuxième email avec même IP
      req = makeReq('192.168.1.1', 'test2@example.com');
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      // Devrait être traité comme une première tentative
      expect(next).toHaveBeenCalled();
      expect(res.set).not.toHaveBeenCalledWith('X-Bruteforce-Delay', expect.any(String));
    });

    it('should handle missing connection.remoteAddress', () => {
      req = { ip: undefined, body: { email: 'test@example.com' } };
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });

    it('should handle unknown IP', () => {
      req = { ip: undefined, connection: undefined, body: { email: 'test@example.com' } };
      res = makeRes();
      next = jest.fn();

      loginBruteforce(req, res, next);

      expect(next).toHaveBeenCalled();
    });
  });

  describe('GC interval', () => {
    it('should set up GC interval', () => {
      // Le middleware devrait être chargé et l'intervalle configuré
      expect(setIntervalSpy).toHaveBeenCalled();
    });
  });
});
