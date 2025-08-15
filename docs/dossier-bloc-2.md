# Safran : Conception & Développement

## 1. Introduction et contexte

### Présentation

Ce projet consiste à concevoir et développer une application mobile de jeu de cartes multijoueur et multiplateforme (iOS / Android) destinée à des parties rapides et engageantes, accessibles à tous types de joueurs.  
L’application permet aux utilisateurs de jouer aussi bien en local (Bluetooth / Wi-Fi) qu’en ligne, en intégrant des fonctionnalités telles que :
- Le matchmaking,
- Un mode spectateur,
- Des classements et statistiques,
- Des achats intégrés futurs.

L’objectif est de proposer une expérience ludique, fluide et innovante, avec des règles originales favorisant à la fois la jouabilité et l’accessibilité.

Ce projet a pour vocation de s’inscrire dans un écosystème de jeux mobiles modernes. À terme, il pourra être enrichi par de nouveaux modes de jeu, des événements communautaires, ou une monétisation progressive via des achats intégrés.

### Objectifs du Projet

Le projet vise les objectifs suivants :
- **Multiplateforme** : Développement avec Flutter pour une compatibilité iOS/Android.
- **Performance** : Backend léger, usage de SQLite pour le local et MySQL pour le distant.
- **Ergonomie** : Interface intuitive avec des animations et gestuelles tactiles adaptées.
- **Maintenance & Monitoring** : Utilisation de Docker Swarm, Prometheus et Grafana pour surveiller la production et faciliter le déploiement.

Le projet permet de mobiliser l’ensemble des compétences du Bloc 2, notamment :
- la mise en place d’un système d’intégration continue,
- la conception de tests unitaires,
- le développement d’un logiciel sécurisé et accessible,
- ainsi que la rédaction des livrables techniques attendus.

### Public Cible

L’application est conçue pour répondre aux attentes de plusieurs profils :
- **Joueurs de jeux de société / vidéo** : mécanique ludique classique augmentée par le numérique.
- **Compétiteurs** : progression, scoring, matchmaking.
- **Créateurs de contenu** : parties spectateurs, événements, tournois.
- **Jeunes adultes en mobilité** : sessions de 5-10 minutes, prise en main instantanée.

L’objectif stratégique est de positionner l’application à l’intersection entre les jeux casual et compétitifs.

### Contexte de Réalisation

Le développement est pris en charge par une équipe d’étudiants, dans le cadre d’un projet pédagogique de fin de formation.  
Le projet respecte un cycle de développement Agile, avec :
- GitHub pour le code source,
- GitHub Actions pour l’intégration continue,
- ClickUp pour le suivi et la planification,
- Android Studio comme IDE principal.

---

## 2. Protocole de déploiement continu

### Objectifs et contexte

Automatiser la mise à disposition des versions Android (APK) pour testeurs via Firebase.

### Outils utilisés

| Outil          | Rôle                                                         |
|----------------|--------------------------------------------------------------|
| GitHub Actions | Automatiser les étapes de build et déploiement               |
| Flutter        | Compilation de l’APK Android (`flutter build apk`)           |
| Firebase       | Déploiement et distribution automatique via App Distribution |
| App Tester     | Accès aux dernières APK pour testeurs via Firebase           |

### Mise en œuvre

Défini dans le fichier `test-build-versioning-deploy.yml` :
- **Déclenchement automatique** : à chaque `push` sur `main`
- **Build Flutter** : `flutter build apk --release`
- **Validation de version** : via `validate-version.yml`
- **Déploiement Firebase** : APK envoyée, testeurs notifiés via App Tester

---

## 3. Protocole d’intégration continue

### Configuration de la CI

CI centralisée sur GitHub Actions, avec 3 workflows :
- `validate-version.yml` : vérifie le label de la PR et incrémente la version du `pubspec.yaml`
- `test-build-versioning.yml` : exécution des tests et compilation sur `dev`
- `test-build-versioning-deploy.yml` : exécution des tests, compilation et déploiement sur `main`

### Logique des pipelines

- **validate-version.yml** (PR sur `dev`) :
  - `fix` → patch (x.y.z+1)
  - `feature/minor` → mineure (x.y+1.0)
  - `major` → majeure (x+1.0.0)

`TODO : Image workflow validate-version.yml` 

- **test-build-versioning.yml** (push sur `dev`) :
  - Tests unitaires
  - Génération de l’APK de développement
  - Un tag de version est automatiquement créé avec le suffixe `-dev` (ex : `v1.0.5-dev`)

`TODO : Image workflow test-build-versioning.yml`

- **test-build-versioning-deploy.yml** (push sur `main`) :
  - Exécution des tests
  - Envoi du coverage à Sonar
  - Build final de l’APK
  - Un tag de version est automatiquement créé avec le suffixe `-release` (ex : `v1.0.5-release`)
  - Déploiement sur Firebase App Distribution
  - Notification App Tester

`TODO : Image workflow test-build-versioning-deploy.yml`  
`TODO : Image des artifacts du workflow`

---

## 4. Critères de qualité et de performance

### 1. Indicateurs suivis

- **Indicateur de sécurité du code** : % de lignes de code protégées contre un piratage  
- **Fiabilité du code** : % de lignes renvoyant un résultat différent de celui attendu  
- **Couverture du code** : % de lignes de code testées  
- **Maintenabilité du code** : % de lignes de code qui ne sont plus à jour avec la technologie utilisée (nombre de lignes obsolètes)  
- **Duplication du code** : % de lignes dupliquées dans le code  

### Indicateurs disponibles après déploiement sur Play Store & App Store :
- **Notes des utilisateurs** : note sur 5 donnée par les utilisateurs  
- **Nombre de téléchargements et comptes actifs**  
- **Taux de désinstallation** : % de personnes ayant désinstallé l’application  
- **Répartition par pays, appareil et version** : % d’installations par pays, par appareil et par version de téléphone  
- **Performance technique** : taux de crash de l’application avec rapport associé, temps de lancement moyen de l’application  
- **Comportement des joueurs** : % de rétention des joueurs à 1, 7 et 30 jours, temps d’utilisation par session utilisateur  
- **% de conversion** : nombre de personnes installant l’application par rapport au nombre de personnes visitant la page de l’application  

### 2. Seuils de performance

- **Indicateur de sécurité du code** : 100%  
- **Fiabilité du code** : 100%  
- **Couverture du code** : 96.5%  
- **Maintenabilité du code** : 100%  
- **Duplication du code** : 0%  

### 3. Outils de mesure

- **SonarQube** : pour les statistiques sur le code  
- **Google Play Console** & **Apple App Store Connect** : pour les statistiques utilisateurs  

---

## 5. Architecture logicielle structurée

### Modèle architectural choisi

| **Cible** | **Architecture** | **Justifications** |
|-----------|------------------|--------------------|
| **Écosystème global** | **Client-Server** | - Gestion centralisée des données (scores, statistiques, matchmaking) : un serveur unique assure l’intégrité des informations et la persistance des données.<br>- Sécurité et contrôle : Les données sensibles (identifiants, progression) sont traitées et stockées de manière sécurisée côté serveur.<br>- Évolutivité : Il est plus facile de faire évoluer la logique métier (back-end) sans imposer de mises à jour constantes sur tous les clients. |
| **Application mobile** | **Component-Based Architecture** | - Découpage logique : L’application est découpée en composants (modules) clairement définis (ex. module de gestion de session, module d’animation UI, module d’IA si nécessaire) afin de mieux organiser le code.<br>- Maintenance allégée : Les composants étant faiblement couplés, il est plus simple de remplacer ou de mettre à jour un composant sans impacter toute l’application.<br>- Collaboration : Plusieurs développeurs peuvent travailler simultanément sur des composants différents de manière indépendante. |
| **Application mobile** | **Peer-to-Peer** | - Mode local (Bluetooth/Wi-Fi) : Permet à des joueurs proches de se connecter directement entre leurs appareils sans passer par un serveur central.<br>- Réduction de la latence dans les parties locales, car la communication ne transite pas par Internet.<br>- Résilience : En cas de coupure réseau, le P2P local peut continuer à fonctionner. |
| **API** | **MVC** | - Séparation des responsabilités : contrôleurs pour l’interface HTTP (routing/DTO), services pour la logique métier, repositories/DAO pour la persistance — code plus lisible et modulable.<br>- Testabilité : le domaine se teste sans HTTP ni base de données, et les contrôleurs se vérifient par tests d’intégration ciblés.<br>- Évolutivité : on peut faire évoluer la couche transport (REST → GraphQL/gRPC) ou remplacer une base de données/tiers sans impacter la logique métier.<br>- Contrats d’API explicites : DTO/serializers et contrôleurs structurent la documentation, le versionnage et les dépréciations. |
| **API** | **Middleware** | - Préoccupations transverses centralisées : authentification/autorisation (JWT/OAuth2), CORS, rate limiting, compression, caching HTTP/ETag, i18n, headers de sécurité.<br>- Observabilité et qualité : logging structuré, corrélation (traceId), métriques et APM uniformes pour toutes les requêtes/réponses.<br>- Gestion des erreurs homogène : un middleware d’erreurs transforme les exceptions en réponses JSON standardisées (codes, messages, détails traçables).<br>- Performance et sécurité : filtres précoces (validation, anti-abus) stoppent les requêtes invalides avant la logique métier et réduisent la charge.<br>- Composabilité : activation/désactivation de briques par environnement (dev/stage/prod) sans modifier les contrôleurs/services.<br>- Conformité et maintenance : politiques de sécurité et de conformité appliquées de façon uniforme, facilitant les audits et les mises à jour. |

---

## 7. Framework et paradigmes utilisés

| **Technologies utilisées** | **Raisons du choix** | **Paradigmes de développement** |
|----------------------------|----------------------|----------------------------------|
| **Flutter (Dart)** – Application mobile multiplateforme | - Développement unique pour Android et iOS, réduisant le coût et le temps de développement.<br>- Performance proche du natif grâce au moteur de rendu Flutter.<br>- Large écosystème de widgets et communauté active.<br>- Hot reload pour un cycle de développement rapide. | - Programmation orientée objet (POO) avec classes et héritage.<br>- Approche déclarative pour la construction d’UI.<br>- Architecture Orientée Composants possible pour séparer la logique et la présentation. |
| **ExpressJS (Node.js)** – API backend | - Framework minimaliste et flexible pour Node.js.<br>- Large écosystème de middlewares.<br>- Facile à intégrer avec des bases de données et services externes.<br>- Rapidité de développement et bonne scalabilité horizontale. | - Architecture MVC avec pipeline de middlewares.<br>- Programmation orientée événement.<br>- Asynchrone/non-bloquant via Promises/async-await. |
| **Prometheus & Grafana** – Monitoring et observabilité | - Prometheus : collecte métriques précises, langage de requêtes puissant (PromQL).<br>- Grafana : visualisations personnalisables et intégration avec de multiples sources de données.<br>- Open-source, flexible et extensible. | - Paradigme événementiel pour l’alerte (alerting rules).<br>- Monitoring basé sur la collecte pull de métriques et dashboards dynamiques. |
| **MySQL** – Base de données serveur | - Système de gestion de base relationnelle éprouvé.<br>- Bon support des transactions et intégrité référentielle.<br>- Large compatibilité avec outils et ORM. | - Paradigme relationnel (SQL).<br>- Modélisation en tables et relations normalisées. |
| **SQLite** – Base de données locale mobile | - Léger, embarqué, aucune configuration serveur.<br>- Parfait pour stockage local offline et synchronisation différée.<br>- Intégré nativement avec Flutter via packages. | - Paradigme relationnel (SQL).<br>- Base locale embarquée. |
| **GitHub Actions & Docker** – CI/CD et déploiement | - GitHub Actions : automatisation des tests, builds, déploiements.<br>- Docker : uniformisation des environnements et isolation applicative.<br>- Déploiement reproductible et portable sur différentes plateformes. | - Paradigme DevOps (CI/CD).<br>- Infrastructure as Code via Dockerfiles et workflows YAML.<br>- Automatisation des processus de build/test/deploy. |

---

## 8. Jeu de test unitaire

> Tous les tests ci-dessous permettent de vérifier les règles métiers, les conditions de victoire, les erreurs de configuration et les effets des cartes du jeu. 
> La mention "Conforme" est attribuée lorsque aucune erreur n’est détectée, et que le résultat correspond à l'attendu.

### Liste des scénarios

| Fonctionnalité testée              | Scénario de test                                              | Résultat attendu                                             | Résultat obtenu | Statut |
|------------------------------------|---------------------------------------------------------------|--------------------------------------------------------------|-----------------|--------|
| Sélection de carte                 | Le joueur sélectionne une carte valide pendant son tour       | La carte est jouée et l'effet est appliqué                   | Conforme        | ✅      |
| Mécanique de victoire par conquête | Tous les territoires adverses sont conquis                    | La partie se termine avec une victoire                       | Conforme        | ✅      |
| Création d'une partie (3 joueurs)  | Lancement d'une partie avec 3 joueurs                         | 3 joueurs, 20 cartes/joueur, 1 carte champ de bataille       | Conforme        | ✅      |
| Création d'une partie (4 joueurs)  | Lancement d'une partie avec 4 joueurs                         | 4 joueurs, 15 cartes/joueur, 1 carte champ de bataille       | Conforme        | ✅      |
| Création d'une partie (5 joueurs)  | Lancement d'une partie avec 5 joueurs                         | 5 joueurs, 12 cartes/joueur, 1 carte champ de bataille       | Conforme        | ✅      |
| Création d'une partie (6 joueurs)  | Lancement d'une partie avec 6 joueurs                         | 6 joueurs, 10 cartes/joueur, 1 carte champ de bataille       | Conforme        | ✅      |
| Échec si moins de 3 joueurs        | Tentative de créer une partie à 2 joueurs                     | Exception levée : nombre de joueurs invalide                 | Conforme        | ✅      |
| Échec si plus de 6 joueurs         | Tentative de créer une partie à 8 joueurs                     | Exception levée : nombre de joueurs invalide                 | Conforme        | ✅      |
| Échec si deck vide                 | Distribution des cartes avec un paquet vide                   | Exception levée : deck vide                                  | Conforme        | ✅      |
| Mécanique pause et exclusion       | Un joueur se met en pause puis est exclu                      | Le joueur est exclu et le jeu continue                       | Conforme        | ✅      |
| Victoire unique                    | Tous les joueurs sauf un sont éliminés                        | Le dernier joueur est déclaré gagnant                        | Conforme        | ✅      |
| Égalité                            | Trois joueurs sont éliminés simultanément                     | La partie se termine sur une égalité                         | Conforme        | ✅      |
| Effet d’une carte jouée            | Jouer une carte avec effet et cible                           | Effet appliqué, état modifié pour la cible                   | Conforme        | ✅      |
| Contre d'une carte                 | Jouer une carte avec un effet de contre (applicable)          | Effet appliqué, joueur contré défausse                       | Conforme        | ✅      |
| Contre incorrect                   | Jouer une carte avec un effet de contre (non applicable)      | Effet non appliqué                                           | Conforme        | ✅      |

### Bilan de la couverture actuelle

| Total des tests définis | Tests passés | Tests en échec |
|-------------------------|--------------|----------------|
| 47                      | 47           | 0              |

`TODO : Image du tableau de couverture des tests SonarCloud`

---

## 10. Accessibilité

### Normes appliquées

Le projet se conforme aux recommandations du **WCAG 2.1 niveau AA**, qui représente aujourd’hui le **standard international de référence** en matière d’accessibilité numérique pour le web et les applications mobiles.

Le choix de la version **2.1** plutôt que la 2.0 s’explique par l’ajout de critères mieux adaptés aux **usages mobiles**, aux **troubles cognitifs** et à la **basse vision**. Ces apports sont essentiels dans le cadre d’une application Flutter destinée à une utilisation tactile sur smartphone et tablette.

Le niveau de conformité **AA** a été retenu, car il offre un **équilibre pertinent entre exigence et faisabilité** : il couvre efficacement les besoins des personnes malvoyantes, daltoniennes, ou ayant des difficultés de compréhension, sans imposer les contraintes très strictes du niveau AAA (comme l’évitement complet d’animations ou la navigation 100 % vocale/clavier).

### Fonctionnalités dédiées

| Fonctionnalité                                        | Description                                                                                                                      |
|-------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|
| **Mode sombre et clair**                              | Deux thèmes (light/dark) accessibles depuis les paramètres, pour s’adapter à la lumière ambiante et réduire la fatigue visuelle. |
| **Mode daltonien**                                    | Filtre de couleur unique basé sur une palette "colorblind safe" (CUD) pour éviter les confusions rouge/vert/bleu.                |
| **Taille de texte adaptable**                         | Texte compatible avec les préférences d’accessibilité du système pour les utilisateurs malvoyants.                               |
| **Navigation tactile simplifiée**                     | Actions réalisables par simple tap, sans geste complexe, facilitant l’usage pour les personnes à motricité réduite.              |
| **Icônes explicites et feedback visuel**              | Boutons accompagnés de texte et d’icônes, avec surbrillance ou confirmation visuelle à l’interaction.                            |
| **Compatibilité partielle avec les lecteurs d’écran** | Éléments critiques annotés avec `Semantics` pour permettre leur lecture par VoiceOver ou TalkBack.                               |

`TODO : Image de l'interface mode claire, sombre et daltonien (si possible avec les icônes explicites)`

---

## 11. Historique des versions

### Versioning

Le projet utilise un schéma de versionnage **sémantique** au format `x.y.z`, où :

- `x` représente une version **majeure**,
- `y` une version **mineure**,
- `z` un **correctif**.

La gestion du versioning est **automatisée** via le pipeline `validate-version.yml`. Lors de chaque PR vers `dev`, un tag (`fix`, `feature`, `major`) détermine l’incrémentation :

- `fix` ➜ `z+1`,
- `feature` ➜ `y+1.0`,
- `major` ➜ `x+1.0.0`.

En complément, la CI ajoute automatiquement un **suffixe** au tag selon la branche :

- `-snapshot` (branche `dev`) pour les versions de test,
- `-release` (branche `main`) pour les versions distribuées.

Le numéro de version est défini dans le fichier `pubspec.yaml`, utilisé par Flutter et mis à jour automatiquement par la CI/CD.

### Journal de modifications (changelog)

| Version        | Date       | Auteur           | Changements principaux                                                                |
|----------------|------------|------------------|---------------------------------------------------------------------------------------|
| 0.9.2-snapshot | 08/07/2025 | Julien FERTILATI | Stabilisation du pipeline CI/CD avec gestion automatisée du versioning                |
| 0.9.1-snapshot | 04/07/2025 | Guilhem MAGAUD   | Ajout de tests unitaires ciblant les composants de jeu (cartes)                       |
| 0.9.0-snapshot | 03/07/2025 | Julien FERTILATI | Intégration de Firebase App Distribution pour le déploiement automatisé               |
| 0.8.0-snapshot | 27/06/2025 | Julien FERTILATI | Ajout de la mécanique de victoire par conquête + correction de bugs sur règles de jeu |
| 0.7.1-snapshot | 23/06/2025 | Anthony VIANO    | Création des templates d’interface responsive pour 3 à 6 joueurs                      |
| 0.7.0-snapshot | 24/06/2025 | Julien FERTILATI | Intégration de SonarCloud pour analyse de qualité + premiers tests automatisés        |
| 0.6.0-snapshot | 13/06/2025 | Guilhem MAGAUD   | Mise en place de la base Flutter : architecture, composants de base et navigation     |
| 0.1.0-snapshot | 03/02/2025 | Julien FERTILATI | Initialisation du projet avec dépôt, structure, premières règles et documentation     |

### Outils de suivi utilisés

| Outil              | Rôle dans le projet                                                                                                      |
|--------------------|--------------------------------------------------------------------------------------------------------------------------|
| **GitHub**         | Suivi des commits, gestion des branches, pull requests et historique de version                                          |
| **ClickUp**        | Suivi de l’avancement, gestion des tâches, organisation des réunions, planification agile et documentation collaborative |
| **SonarCloud**     | Analyse de la qualité du code, détection des bugs et suivis des régressions                                              |
| **GitHub Actions** | Exécution des tests, contrôle du versioning et automatisation du déploiement                                             |
| **Firebase**       | Distribution des APK pour tests via App Distribution, notifications aux testeurs                                         |

---

## 13. Cahier de recettes

| Fonctionnalité testée              | Scénario de test                                              | Résultat attendu                                             | Résultat obtenu | Statut |
|------------------------------------|---------------------------------------------------------------|--------------------------------------------------------------|-----------------|--------|
| Connexion à une partie             | Un joueur entre un code de session                            | La connexion réussit et le joueur rejoint la partie          | Non implémenté  | ❌      |
| Création de lobby P2P local        | Un joueur crée une session locale                             | La session est disponible en réseau local                    | Non implémenté  | ❌      |
| Création de lobby P2P en ligne     | Un joueur crée une session en ligne                           | La session est disponible en ligne                           | Non implémenté  | ❌      |
| Recherche d’un lobby local         | Un joueur cherche une partie disponible dans son réseau local | Les sessions en réseau local apparaissent                    | Non implémenté  | ❌      |
| Recherche d’un lobby en ligne      | Un joueur cherche une partie disponible en ligne              | Les sessions en ligne apparaissent                           | Non implémenté  | ❌      |
| Reconnexion après coupure          | Un joueur se reconnecte après une déconnexion                 | La session reprend à l’état précédent                        | Non implémenté  | ❌      |
| Notification de nouvelle version   | Une nouvelle version est déployée sur Firebase                | Les testeurs reçoivent une notification via App Tester       | Conforme        | ✅      |
| Historique des parties             | L'utilisateur consulte ses parties précédentes                | Les détails des parties jouées s’affichent correctement      | Non implémenté  | ❌      |

---

## 14. Plan de correction des bugs

### Méthodologie

#### Détection des bugs
Les bugs sont détectés soit lors des tests fonctionnels effectués pendant le développement, soit plus tard par les bêta-testeurs ou les utilisateurs. Pour permettre à l'utilisateur de signaler un bug, un formulaire est mis à disposition avec :
- Un champ **description** pour expliquer le bug
- Un champ **image** (optionnel) pour joindre une capture écran

Une fois le formulaire rempli, un e-mail est envoyé à l'équipe de développement contenant la description du bug et l'éventuelle image. Un ticket est alors ouvert avec un **identifiant unique** et une **description détaillée** du problème.

#### Qualification et priorisation
Chaque bug est évalué par l'équipe, selon deux critères :
- **Sévérité** : insignifiante / mineure / majeure / bloquante
- **Priorité** : basse / normale / haute / urgente

Ce double classement permet de déterminer l'ordre de traitement des bugs.

`TODO : Image de la grille de priorisation des bugs`

#### Reproduction du problème
Dans le ticket, une section **"Repro-step"** (scénario de reproduction) est renseignée pour permettre à n'importe quel développeur de reproduire l'anomalie.
Cette section peut être enrichie par :
- Captures d'écran
- Extraits de logs

Si le bug a été signalé par un utilisateur, un développeur se charge d'en vérifier la reproductibilité et documente le ticket en conséquence.

#### Analyse et diagnostic
Le développeur en charge du ticket identifie la **cause racine** du bug et évalue s'il peut avoir des impacts sur d'autres parties du code. Cette analyse permet d'éviter les régressions.

#### Correction
Une fois la cause identifiée, le développeur corrige le bug dans l'environnement de développement.
Une **revue de code** est ensuite réalisée par un deuxième développeur afin de :
- Valider le respect des normes de développement
- Vérifier qu'aucune autre fonctionnalité n'est impactée par le bug et / ou la correction effectuée

#### Validation
Après validation technique :
- Les **tests unitaires et d'intégration** sont relancés
- Un troisième développeur effectue un **test fonctionnel** du correctif

Les fonctionnalités liées sont également testées pour écarter tout effet de bord.

#### Mise en production
Lorsque le correctif est validé :
- Une branche de correctifs est créée à partir de `dev` vers `main`
- Le correctif est déployé via le pipeline CI/CD
- Un **changelog** est mis à jour pour décrire les fix

#### Suivi post-déploiement
Après mise en production :
- Le comportement de l'application est **monitoré** (logs, erreurs)
- Si aucune anomalie n'est détectée pendant **2 semaines**, le ticket est fermé

### Outils de suivi utilisés

- **ClickUp** : gestion des tickets, suivi de l'avancement, affectation
- **GitHub** : suivi des commits liés aux bugs et automatisation via GitHub Actions
- **SonarCloud** : détection des bugs, duplications, vulnérabilités dans le code via analyse statique, suivi du taux de couverture des tests unitaires et du pourcentage de tests passés
- **Prometheus / Grafana** : supervision technique post-mise en production

Workflow du ticket dans ClickUp : `A Qualifier` → `En cours` → `Test` → `Corrigé` → `Fermé`

`TODO : Image du workflow de ticket dans ClickUp`

### Exemple de bug traité

**Titre** : "La condition d'égalité (match nul) ne se déclenche pas malgré l'élimination simultanée de 3 joueurs"

**Signalement** : détecté lors d’un test automatisé (test unitaire `Tie`)

**Repro-step** :
1. Créer un jeu avec 3 joueurs (P1, P2, P3)
2. Définir leurs decks comme suit :
    - P1 : [ArcherCard(), FakeCard()]
    - P2 : [GuardCard()]
    - P3 : [ConquestKnightCard(), FakeCard(), FakeCard()]
3. Lancer la partie avec `game.startGame(0)`

**Résultat attendu** : `game.isGameOver == true` et `game.winCondition == "Draw: 3 players eliminated after a chain of deaths"`

**Résultat obtenu** : l'état `isGameOver` restait à `false` ou `winCondition` était vide

**Analyse** : le moteur de règles ne gérait pas correctement l’élimination en chaîne de plusieurs joueurs dans le même tour. L'état de fin de partie n'était déclenché que si un seul joueur survivait.

**Correction** :
- Ajout d'une logique de détection d'égalité dans la boucle principale du jeu (`Game.checkEndCondition()`)
- Mise à jour de la méthode `evaluateWinCondition()` pour prendre en compte le scénario de multiple égalité

**Validation** :
- Relance du test unitaire `Tie` : ✅
