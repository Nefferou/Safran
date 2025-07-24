# Safran : Conception & Développement

## 1. Introduction et contexte

### Présentation

Ce projet consiste à concevoir et développer une application mobile de jeu de cartes multijoueur et multiplateforme (iOS / Android) destinée à des parties rapides et engageantes, accessibles à tous types de joueurs.  
L’application permet aux utilisateurs de jouer aussi bien en local (Bluetooth / Wi-Fi) qu’en ligne, en intégrant des fonctionnalités telles que :
- Le matchmaking,
- Un mode spectateur,
- Des classements et statistiques,
- Des achats intégrés futurs.

L’objectif est de proposer une expérience ludique, fluide et innovante, avec des règles originales favorisant à la fois la rejouabilité et l’accessibilité.

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

| Outil             | Rôle                                                                 |
|-------------------|----------------------------------------------------------------------|
| GitHub Actions    | Automatiser les étapes de build et déploiement                       |
| Flutter           | Compilation de l’APK Android (`flutter build apk`)                  |
| Firebase          | Déploiement et distribution automatique via App Distribution         |
| App Tester        | Accès aux dernières APK pour testeurs via Firebase                   |

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
<img width="1312" height="247" alt="image" src="https://github.com/user-attachments/assets/60b2286f-32f8-46a1-8632-f478463fd68f" />

- **test-build-versioning.yml** (push sur `dev`) :
  - Tests unitaires
  - Génération de l’APK de développement
  - Un tag de version est automatiquement créé avec le suffixe `-dev` (ex : `v1.0.5-dev`)
<img width="1309" height="248" alt="image" src="https://github.com/user-attachments/assets/73a49430-0c31-4d83-aaa2-3156806b7a9a" />

- **test-build-versioning-deploy.yml** (push sur `main`) :
  - Exécution des tests
  - Envoi du coverage à Sonar
  - Build final de l’APK
  - Un tag de version est automatiquement créé avec le suffixe `-release` (ex : `v1.0.5-release`)
  - Déploiement sur Firebase App Distribution
  - Notification App Tester
<img width="1293" height="346" alt="image" src="https://github.com/user-attachments/assets/b88f1abe-c47c-4e36-8e03-f5398095d594" />
<img width="1304" height="306" alt="image" src="https://github.com/user-attachments/assets/17c64f45-730c-40e3-9768-12d3c6a6ee66" />


