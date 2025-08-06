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

