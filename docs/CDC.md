# Cahier des Charges - Bloc 1

## 1. Introduction et Contexte
### 1.1 Présentation du Projet
### 1.2 Objectifs
### 1.3 Public Cible

## 2. Parties Prenantes (C1.1.1)

### 2.1 Équipe de développement

| Nom         | Rôle                                      | Responsabilités principales                                                                                                                |
|-------------|-------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| **Julien**  | Chef de projet / Concepteur / Développeur | Gestion du projet, coordination de l’équipe, conception des fonctionnalités, développement **Front / Back**, intégration **Test / CI-CD**. |
| **Anthony** | Concepteur / Développeur                  | Conception et développement **Front / Back**, **réseau**.                                                                                  |
| **Yves**    | Développeur                               | Développement **Back**, gestion **réseau**, supervision de l'application (**Monitoring**), intégration **CI-CD**.                          |
| **Guilhem** | Concepteur / Développeur                  | Conception et développement **Front / Back**, intégration **Test**.                                                                        |

### 2.2 Autres parties prenantes

| Acteur                               | Rôle                                    | Implication                                                                            |
|--------------------------------------|-----------------------------------------|----------------------------------------------------------------------------------------|
| **Utilisateurs finaux**              | Joueurs de l’application mobile         | Attentes en matière d'expérience utilisateur, fluidité et compréhension facile du jeu. |
| **Partenaires commerciaux (futurs)** | Fabricants de jeux de société, sponsors | Potentielle collaboration et monétisation (sponsoring).                                |
| **Plateformes de distribution**      | Google Play Store, Apple App Store      | Publication et respect des guidelines de chaque store.                                 |
| **Communauté & testeurs**            | Bêta-testeurs et premiers utilisateurs  | Feedback sur l’UX/UI et détection des bugs.                                            |

## 2.3 Analyse de la Demande, des Objectifs et des Enjeux des parties prenantes (C1.1.2)

| Partie prenante                 | Demande                                                              | Objectifs                                                   | Enjeux                                                                                         |
|---------------------------------|----------------------------------------------------------------------|-------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| **Équipe de développement**     | Outils adaptés, documentation claire, gestion de projet fluide       | Développer une application stable, performante et évolutive | Respect des délais, bonne collaboration, gestion des ressources techniques                     |
| **Utilisateurs finaux**         | Expérience utilisateur fluide, jeux amusants et faciles à comprendre | Engagement et satisfaction des joueurs                      | Adoption de l’application, fidélisation des utilisateurs, partage du jeu avec d'autres joueurs |
| **Partenaires commerciaux**     | Opportunités de visibilité et intégration commerciale                | Monétisation via publicité, partenariats et sponsoring      | Alignement stratégique avec l’application, impact sur l’image de marque                        |
| **Plateformes de distribution** | Conformité aux politiques de publication                             | Distribution et accessibilité                               | Validation des mises à jour, respect des guidelines techniques et légales                      |
| **Communauté & testeurs**       | Application fonctionnelle et stable                                  | Identification rapide des bugs et améliorations continues   | Engagement des testeurs, qualité du feedback                                                   |

### 3.2 Contraintes (À déplacer)

## 4. Forces, Faiblesses, Opportunités et Menaces (C1.2.1)

| **Forces (S)**                                 | **Faiblesses (W)**                                                       |
|------------------------------------------------|--------------------------------------------------------------------------|
| - Équipe polyvalente et expérimentée.          | - Dépendance à une petite équipe.                                        |
| - Nouveau jeu avec des règles innovantes.      | - Charge de travail importante pour chaque membre.                       |
| - Technologies modernes et multiplateformes.   | - Manque de notoriété du projet au lancement.                            |
| - Expérience utilisateur fluide et engageante. | - Ressources financières limitées pour le développement et le marketing. |

| **Opportunités (O)**                                          | **Menaces (T)**                                                    |
|---------------------------------------------------------------|--------------------------------------------------------------------|
| - Partenariats avec d'autres fabricants de jeux/sponsors.     | - Concurrence forte sur le marché du jeu de cartes en ligne.       |
| - Croissance du marché des applications mobiles.              | - Évolution rapide des technologies menant à des incompatibilités. |
| - Forte demande pour des jeux innovants.                      | - Dépendance aux plateformes de distribution.                      |
| - Intérêt croissant pour les expériences ludiques numériques. | - Risque de piratage ou de copie du concept par des concurrents.   |
| - Possibilité d’intégrer des fonctionnalités sociales (chat). | - Réglementations potentielles liées aux jeux numériques.          |

## 5. Spécifications Fonctionnelles et Techniques (C1.4.1, C1.5, C1.2.2)
### 5.1 Fonctionnalités de Base
### 5.2 Fonctionnalités Secondaires
### 5.3 Technologies Utilisées
### 5.4 Architecture Logicielle
### 5.5 Audit de Faisabilité

| **Faisabilité technique**                                                                                                                                                                                                                                                         | **Faisabilité financière**                                                                   |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| - Compatible cross-platform iOS/Android, avec utilisation de technologies comme Flutter ou React Native.                                                                                                                                                                          | - Coût de déploiement sur l'App Store et Google Play (frais de publication et mises à jour). |
| - Infrastructure privée : une VM Fedora Server avec 4Go de ram, 20Go de stockage et 4 threads pour le CPU. Nous avons installé les différents packages docker (docker.io, docker-compose, docker swarm). Et les services implémentés sur la VM sont Prometheus, Grafana et MySQL. | - Coût de l'infrastructure serveurs, ajustable selon le nombre d'utilisateurs actifs.        |
| - Implémentation d’un système de matchmaking et gestion avancée des salles de jeu.                                                                                                                                                                                                | - Mise en place d’achats in-app et d’un abonnement premium pour monétisation.                |
| - Gestion robuste de la déconnexion/reconnexion avec reprise de partie en temps réel.                                                                                                                                                                                             | - Budget marketing pour acquisition et fidélisation des joueurs.                             |
| - Base de données optimisée (PostgreSQL, MySQL, SQLite, Firebase, MongoDB) pour stocker profils joueurs et statistiques.                                                                                                                                                          | - Coût de maintenance et de mises à jour régulières pour assurer la stabilité.               |
| - Utilisation d’une architecture microservices ou serverless pour scalabilité.                                                                                                                                                                                                    | - Estimation des coûts liés au support client et aux serveurs multijoueurs.                  |

| **Faisabilité organisationnelle**                                                                                                  | **Faisabilité temporelle**                                                   |
|------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| - Utilisation de méthodologies Agile/Scrum pour optimiser la production.                                                           | - Définition d’un calendrier prévisionnel réaliste avec étapes clés.         |
| - Collaboration avec des testeurs et la communauté pour améliorer l’UX/UI.                                                         | - Identification des risques de retard suite au manque de ressource.         |
| - Mise en place d’une stratégie de communication pour faire connaître l'application et fidéliser les joueurs via des mises à jour. | - Plan de lancement par étapes : prototype > bêta > version finale.          |
| - Mise en place d'un système d'analyse des statistiques du jeu pour ajuster les mécaniques.                                        | - Planification des futures mises à jour pour assurer une longévité du jeu.  |


## 6. Cartographie des Risques et Indicateurs (C1.2.3)
### 6.1. Risques Techniques
### 6.2. Risques Fonctionnels
### 6.3. Référentiel et Indicateurs de Contrôle

## 7. Veille Technique et Réglementaire (C1.3.1)
### Bénéfices Attendus

## 8. Étude Comparative des Solutions Techniques (C1.3.2)

## 9. Estimation de la Charge de Travail et du Budget (C1.4.1, C1.4.2)
### 9.1 Charge de travail

## 10. Préconisation des Solutions (C1.6)
