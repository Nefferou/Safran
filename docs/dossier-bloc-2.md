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
