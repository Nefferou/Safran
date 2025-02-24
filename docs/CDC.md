# Cahier des Charges - Bloc 1

## 1. Introduction et Contexte

### 1.1 Présentation du Projet
L'objectif du projet est de concevoir une **application mobile de jeu de cartes**, avec des règles innovantes et une expérience utilisateur fluide. Cette application permettra aux joueurs de s'affronter en **local** et en **ligne**, avec des fonctionnalités modernes telles que le matchmaking, un mode multijoueur stable et une interface dynamique.

### 1.2 Objectifs
Les principaux objectifs du projet sont :
- **Développement multiplateforme** : Assurer une compatibilité iOS et Android.
- **Optimisation des performances** : Backend léger et efficace basé avec une base de données adaptée.
- **Expérience utilisateur immersive** : Interface fluide, animations et interactions simplifiées pour améliorer la jouabilité.
- **Facilité de maintenance et scalabilité** : Utilisation de **Docker Compose** pour la gestion des conteneurs et **Prometheus/Grafana** pour le monitoring.

### 1.3 Public Cible
L'application s'adresse à :
- **Joueurs occasionnels et compétitifs** : Personnes cherchant une expérience de jeu rapide et intuitive.
- **Amateurs de jeux de société numériques** : Ceux qui souhaitent retrouver l’ambiance des jeux de cartes classiques sur mobile.
- **Jeunes adultes et familles** : Un public cherchant un jeu accessible à tous, avec des parties rapides et engageantes.
- **Créateurs de contenu et influenceurs** : Potentiel de viralité grâce à des défis, tournois et interactions sociales intégrées.

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
| - Infrastructure privée : une VM Debian avec 4Go de ram, 20Go de stockage et 4 threads pour le CPU. Nous avons installé les différents packages docker (docker.io, docker-compose, docker swarm). Et les services implémentés sur la VM sont Prometheus, Grafana et MySQL. | - Coût de l'infrastructure serveurs, ajustable selon le nombre d'utilisateurs actifs.        |
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


## 6 Cartographie des Risques Techniques et Fonctionnels (C1.2.3)

### 6.1 Risques Techniques

| **Risques**                                                             | **Criticité** | **Impact**                                                                 | **Mesures d'atténuation**                                                                                                                |
|-------------------------------------------------------------------------|---------------|----------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| Bugs et instabilités affectant l’expérience utilisateur                 | Élevée        | Expérience utilisateur dégradée                                            | Mise en place de tests unitaires et d'intégration                                                                                        |
| Problèmes de compatibilité entre différentes plateformes et versions OS | Moyenne       | Incompatibilité et frustration des joueurs                                 | Tests sur différents appareils et systèmes d’exploitation                                                                                |
| Failles de sécurité entraînant des fuites de données                    | Critique      | Violation des données et perte de confiance                                | Chiffrement des données et audits de sécurité réguliers                                                                                  |
| Latence en cas de connexion instable de certains joueurs                | Élevée        | Temps de réponse allongé et expérience utilisateur dégradée en multijoueur | Mise en place de serveurs intermédiaires (brokers) pour équilibrer les connexions et éviter des écarts trop importants entre les joueurs |

### 6.2 Risques Fonctionnels

| **Risques**                                                           | **Criticité** | **Impact**                            | **Mesures d'atténuation**                                                                 |
|-----------------------------------------------------------------------|---------------|---------------------------------------|-------------------------------------------------------------------------------------------|
| Règles du jeu mal comprises par les utilisateurs                      | Moyenne       | Abandon précoce du jeu                | Tutoriels interactifs et explications claires                                             |
| Manque d’engagement des joueurs à long terme                          | Élevée        | Baisse de la rétention utilisateur    | Ajout de contenus évolutifs et de modes spéciaux                                          |
| Dépendance aux plateformes de distribution (Google Play, App Store)   | Critique      | Risque de suppression ou restrictions | Diversification des canaux de distribution et respect des guidelines                      |
| Manque de visibilité de l’application et faible notoriété             | Élevée        | Faible adoption                       | Stratégie marketing ciblée, publication sur les réseaux et partenariats avec influenceurs |
| Non-conformité aux réglementations sur la confidentialité des données | Critique      | Sanctions légales                     | Respect des normes RGPD et mise en place d’une politique de confidentialité transparente  |

### 6.3 Référentiel des Risques

- **Faible** : Surveillance minimale.
- **Moyenne** : Actions préventives mises en place.
- **Élevée** : Surveillance accrue et plan d’action immédiat.
- **Critique** : Intervention prioritaire et mesures correctives immédiates.

### 6.4 Indicateurs de Contrôle

- **Taux de plantage de l’application** : Nombre de crashs pour 100 parties.
- **Temps de réponse moyen** : Temps nécessaire pour charger les éléments interactifs.
- **Nombre d’incidents de perte de données** : Fréquence des problèmes signalés.
- **Taux de satisfaction utilisateur** : Mesuré à travers des retours et enquêtes.
- **Taux de rétention des utilisateurs** : Mesure la fidélisation sur 60/120/180 jours.
- **Respect des exigences des plateformes** : Nombre de rejets des mises à jour par Google Play/App Store.
- **Audit de conformité RGPD** : Nombre d’irrégularités détectées lors des audits.

## 7. Veille Technique et Réglementaire (C1.3.1)

### Bénéfices Attendus

## 9. Estimation de la Charge de Travail et du Budget (C1.4.2)

### Temps moyen estimé par poste avec justification

| **Poste**                      | **Temps estimé (Jours/Homme)** | **Justification**                                                                                                                                                                                                                                                                       |
|--------------------------------|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Développement Front-end**    | **50 - 70 J/H**                | Une application mobile de jeu de cartes comme **Uno** nécessite plusieurs **écrans interactifs** (menu, salon, table de jeu, scores) et une bonne fluidité pour l’expérience utilisateur. Flutter permet un gain de temps grâce à une base de code unique pour iOS et Android.          |
| **Développement Back-end**     | **50 - 70 J/H**                | La mise en place de l'API et la gestion des utilisateurs prennent du temps. Cela inclut le **matchmaking, la gestion des connexions instables et la synchronisation en temps réel** avec plusieurs joueurs.                                                                             |
| **Infrastructure**             | **20 - 40 J/H**                | Mise en place de la base de données et de la partie DevOps de l'application, incluant la gestion des déploiements et la scalabilité.                                                                                                                                                    |
| **Sécurité & RGPD**            | **10 J/H**                     | Toute application en ligne manipulant des **données utilisateur (compte, scores)** doit respecter la **RGPD et sécuriser les données** (hashing des mots de passe, chiffrement des communications). Gestion des permissions et accès (ex. tokens JWT, OAuth2, etc.).                    |
| **Design UI/UX**               | **10 - 40 J/H**                | Un jeu mobile nécessite une **interface simple mais engageante** avec des animations et effets visuels fluides. De plus, les cartes doivent être conçues pour correspondre à l'ambiance souhaitée.                                                                                      |
| **Tests & QA**                 | **10 - 30 J/H**                | Plus il y a d’interactions et de fonctionnalités en ligne, plus il faut tester différents scénarios de **jeu en solo/multijoueur**, la gestion des déconnexions et la compatibilité mobile. Tests unitaires, tests d’intégration, tests UX/UI, tests de charge et tests de performance. |
| **Maintenance & Mises à Jour** | **10 - 30 J/H/an**             | Plus il y a de joueurs actifs, plus il faut assurer des **mises à jour fréquentes** pour **corriger les bugs et ajouter du contenu**. Configuration d’outils de monitoring comme Prometheus, Grafana, Datadog, ELK (Elastic, Logstash, Kibana).                                         |
| **Marketing**                  | **Variable**                   | Une application mobile de jeu de cartes est dans un marché **très compétitif**, donc il faudra un bon travail sur le **référencement dans l’App Store (ASO)** et le marketing sur **réseaux sociaux**.                                                                                  |

_**Précision** : Le temps estimé dans ce tableau est calculé pour une **équipe de développeurs juniors**, en prenant en compte une **productivité moindre, un besoin d’apprentissage et plus d’itérations pour les corrections**._

### Estimation des Coûts et taux journaliers moyens

| **Poste**                      | **Taux journalier moyen (€)** | **Coût estimé min (€)** | **Coût estimé max (€)** |
|--------------------------------|-------------------------------|-------------------------|-------------------------|
| **Développement Front-end**    | **200 €/JH**                  | **10 000 €**            | **14 000 €**            |
| **Développement Back-end**     | **300 €/JH**                  | **15 000 €**            | **21 000 €**            |
| **Infrastructure**             | **450 €/JH**                  | **9 000 €**             | **18 000 €**            |
| **Sécurité & RGPD**            | **300 €/JH**                  | **3 000 €**             | **3 000 €**             |
| **Design UI/UX**               | **180 €/JH**                  | **1 800 €**             | **7 200 €**             |
| **Tests & QA**                 | **200 €/JH**                  | **2 000 €**             | **6 000 €**             |
| **Maintenance & Mises à Jour** | **250 €/JH**                  | **2 500 €**             | **7 500 €**             |
| **Marketing**                  | **200 €/JH**                  | **-**                   | **-**                   |
| **Total**                      | **-**                         | **42 500 €**            | **76 700 €**            |
=======

## 8. Étude Comparative des Solutions Techniques (C1.3.2)

### 8.1 Technologies Front-End

| **Technologie**   | **Description**                                                                                                                                                                                                                                                      | **Avantages**                                                                                                                                                                                                                                                                      | **Inconvénients**                                                                                                                                                                                                          |
|-------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Flutter**       | Framework open-source développé par Google permettant de créer des applications mobiles avec un code unique en **Dart**. Utilise son propre moteur de rendu pour une interface fluide et personnalisable. Supporte également **Flutter Web** et **Flutter Desktop**. | - Code multiplateforme (iOS, Android, Web, Desktop).<br>- Performances élevées grâce à son moteur de rendu natif.<br>- Interface personnalisable avec des widgets flexibles et modernes.<br>- Large communauté et support de Google.<br>- Hot Reload pour un développement rapide. | - Poids des applications plus élevé que les solutions natives.<br>- Certaines limitations de performances par rapport au développement natif.<br/>- Certaines fonctionnalités nécessitent l'utilisation de modules natifs. |
| **React Native**  | Framework JavaScript open-source créé par Facebook, permettant le développement multiplateforme en **React**.                                                                                                                                                        | - Large communauté et support actif.<br>- Développement rapide avec Hot Reload.<br>- Code réutilisable entre iOS, Android et Web.<br>- Possibilité d’améliorer les performances avec des **modules natifs**.                                                                       | - Moins performant que les solutions 100% natives.<br>- Certaines fonctionnalités nécessitent l'utilisation de modules natifs.                                                                                             |
| **Kotlin / Java** | Langage moderne et officiel pour le développement Android.                                                                                                                                                                                                           | - Syntaxe concise et efficace.<br>- Performances optimisées pour Android.<br>- Support officiel de Google.                                                                                                                                                                         | - Courbe d’apprentissage pour les débutants.<br>- Code spécifique à Android (non multiplateforme).                                                                                                                         |
| **Swift**         | Langage officiel d’Apple pour le développement iOS et macOS.                                                                                                                                                                                                         | - Performances optimales pour les applications iOS.<br>- Syntaxe moderne et expressive.<br>- Sécurité renforcée par rapport à Objective-C.                                                                                                                                         | - Courbe d’apprentissage importante.<br>- Non multiplateforme.<br/>                                                                                                                                                        |

### 8.2 Technologies Back-End

| **Technologie** | **Description**                                                                          | **Avantages**                                                                                                                                | **Inconvénients**                                                                                                               |
|-----------------|------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|
| **ExpressJs**   | Framework minimaliste basé sur Node.js pour développer des API légères et performantes.  | - Idéal pour les applications en temps réel.<br>- Large écosystème et communauté.<br>- Facile à apprendre et rapide à déployer.              | - Moins adapté aux calculs lourds en raison de son architecture single-threaded.<br>- Gestion avancée des erreurs à configurer. |
| **Spring Boot** | Framework Java robuste permettant de développer des API REST performantes et sécurisées. | - Sécurisé et adapté aux grandes applications.<br>- Forte communauté et écosystème mature.<br>- Bonne gestion des transactions et des accès. | - Courbe d'apprentissage plus élevée.<br>- Temps de développement plus long que les solutions plus légères.                     |
| **Flask**       | Framework minimaliste en Python, adapté aux petits projets et aux microservices.         | - Facile à apprendre et rapide à configurer.<br>- Idéal pour les petites applications et APIs légères.                                       | - Moins performant pour les applications complexes.<br>- Manque d’outils intégrés pour les grandes applications.                |

### 8.3 Technologies de Monitoring

| **Technologie**                     | **Description**                                                                                              | **Avantages**                                                                                                                                                           | **Inconvénients**                                                                                                                                            |
|-------------------------------------|--------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Prometheus / Grafana**            | Outils open-source permettant la collecte et la visualisation des métriques applicatives.                    | - Performant pour collecter un grand volume de données temporelles.<br>- Intégration facile avec Grafana pour visualisation.<br>- Système d’alertes avancé.             | - Stockage limité sur le long terme (nécessite des extensions comme Thanos pour l’historisation des données).<br>- Configuration avancée peut être complexe. |
| **ELK (Elastic, Logstash, Kibana)** | Suite d’outils open-source permettant la collecte, l’analyse et la visualisation des logs d’une application. | - Collecte et centralisation efficace des logs.<br>- Visualisation avancée des données avec Kibana.<br>- Recherche rapide et indexation performante avec Elasticsearch. | - Consommation mémoire et CPU importante.<br>- Optimisation nécessaire via **sharding** et **gestion avancée des indices**.                                  |
| **New Relic**                       | Solution cloud pour le monitoring des performances applicatives (APM).                                       | - Monitoring complet (serveur, application, base de données).<br>- Facile à intégrer avec le cloud.<br>- Visualisation avancée des logs et performances.                | - Coût élevé pour les grandes applications.<br>- Complexe pour une petite équipe.                                                                            |

### 8.4 Bases de Données

| **Technologie**                      | **Description**                                                                                    | **Avantages**                                                                                                                                               | **Inconvénients**                                                                                                |
|--------------------------------------|----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| **PostgreSQL / MySQL (Relationnel)** | Bases de données relationnelles robustes et adaptées aux transactions complexes.                   | - Fiable et sécurisé.<br>- Gestion efficace des transactions.<br>- PostgreSQL permet le stockage de données semi-structurées via **JSONB**.                 | - Moins adapté aux très gros volumes de données non structurées.<br>- Configuration et maintenance plus lourdes. |
| **SQLite (SQL local)**               |                                                                                                    |                                                                                                                                                             |                                                                                                                  |
| **MongoDB (NoSQL)**                  | Base de données NoSQL orientée documents, idéale pour stocker des données flexibles et évolutives. | - Parfait pour les données non structurées.<br>- Facile à scaler horizontalement.<br>- Performant pour les requêtes rapides sur de gros volumes de données. | - Moins adapté aux transactions complexes.<br>- Consommation mémoire plus élevée.                                |

### 8.5 DevOps & Déploiement

| **Technologie**    | **Description**                                                                                      | **Avantages**                                                                                                                                                                                      | **Inconvénients**                                                                                                                                               |
|--------------------|------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Kubernetes**     | Plateforme d’orchestration de conteneurs.                                                            | - Scalabilité automatique.<br>- Haute disponibilité.<br>- Compatible avec le cloud et infrastructures on-premise.<br>- **Alternatives légères** : Minikube et K3s pour les environnements de test. | - Configuration complexe.<br>- Consommation élevée en ressources.                                                                                               |
| **Docker Swarm**   | Orchestration native pour Docker permettant la gestion simplifiée des conteneurs.                    | - Facile à mettre en place pour un projet de taille moyenne.<br>- Intégration simple avec Docker.<br>- Moins complexe que Kubernetes.                                                              | - Moins robuste et évolutif pour une application à fort trafic.<br>- Moins d’outils avancés pour le scaling et monitoring.                                      |
| **GitHub Actions** | Service d’intégration et déploiement continu (CI/CD) intégré à GitHub.                               | - Automatisation des tests et déploiements.<br>- Intégration native avec GitHub.<br>- Personnalisable avec des workflows YAML.                                                                     | - Moins de flexibilité que Jenkins pour des configurations avancées.<br>- Peut être limité pour des projets complexes nécessitant des intégrations spécifiques. |
| **Jenkins**        | Outil open-source permettant d’automatiser les tests, les builds et le déploiement de l’application. | - Automatisation avancée des processus CI/CD.<br>- Grande flexibilité grâce aux plugins.<br>- Supporte plusieurs langages et plateformes.                                                          | - Peut être complexe à configurer.<br>- Nécessite une maintenance régulière.                                                                                    |

### 8.6 Outils de Gestion de Projet

| **Technologie** | **Description**                                                    | **Avantages**                                                                                                                                                  | **Inconvénients**                                                                                                                                                                                                               |
|-----------------|--------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **ClickUp**     | Outil de gestion tout-en-un avec tâches, suivi et automatisations. | - Flexible et personnalisable.<br>- Vues multiples (Kanban, Gantt, calendrier).<br>- Outil performant mais peut **devenir lent** avec trop de tâches ouvertes. | - Peut devenir complexe avec trop de fonctionnalités.                                                                                                                                                                           |
| **Trello**      | Outil de gestion de projet visuel basé sur des cartes.             | - Interface intuitive.<br>- Version gratuite adaptée aux petits projets.                                                                                       | - Fonctionnalités limitées pour les projets complexes.<br>- **Ne permet pas de gérer des dépendances entre tâches**, limitant son efficacité pour des projets avancés.<br/>- Se limite à une vu Kanban pour la version gratuite |
| **Notion**      | Outil combinant gestion de projet et documentation.                | - Très flexible.<br>- Idéal pour la documentation technique et le suivi des tâches.                                                                            | - Peut devenir brouillon si mal structuré.<br>- Version gratuite limitée.                                                                                                                                                       |

## 9. Choix des Technologies

### 9.1 Front-End : **Flutter**

- Permet un **développement multiplateforme** (iOS, Android) avec un code unique, réduisant ainsi les coûts et le temps de développement.
- **Performances optimisées** grâce à son moteur de rendu natif, garantissant une interface fluide.
- **Hot Reload** permet de tester rapidement les modifications, accélérant ainsi le cycle de développement.
- Grande flexibilité avec une **bibliothèque de widgets** modernes et personnalisables.
- Large **communauté** et support de Google, assurant une bonne maintenance et évolution du framework.

### 9.2 Back-End : **Express.js**

- **Léger et rapide**, idéal pour construire des API REST performantes et adaptées aux applications mobiles.
- Fonctionne parfaitement avec **Node.js**, permettant une gestion efficace des requêtes asynchrones.
- **Écosystème riche** avec de nombreux modules et middleware facilitant l’intégration avec d’autres services.

### 9.3 Monitoring : **Prometheus & Grafana**

- **Solution open-source** performante et évolutive pour la **collecte et l’analyse des métriques** applicatives.
- **Prometheus** est optimisé pour la surveillance des services en temps réel et intègre un **système d’alerte avancé**.
- **Grafana** permet de **visualiser facilement** les données via des tableaux de bord interactifs.
- Compatible avec **Docker Swarm**, facilitant le monitoring de l’ensemble de l’infrastructure.

### 9.4 Bases de Données : **SQLite et MySQL**

- **MySQL** est utilisé pour notre **service en ligne**, offrant :
    - **Fiabilité et robustesse** pour la gestion des données utilisateurs et des transactions.
    - Bonne gestion des **requêtes complexes** et intégration avec Express.js.
    - Évolutif et **optimisé pour les applications en production**.
- **SQLite** est utilisé pour le stockage **local sur l’application mobile**, car :
    - Fonctionne sans serveur, idéal pour les **données locales**.
    - Léger et performant pour des **opérations rapides en local**.
    - Permet une **synchronisation** avec MySQL pour les données partagées.

### 9.5 Déploiement : **Docker Swarm**

- **Orchestration simple** des conteneurs Docker, facilitant le déploiement de nos services.
- Moins complexe que Kubernetes, idéal pour une équipe réduite souhaitant **scaler** l’infrastructure sans surcharge technique.
- **Facilité de mise en œuvre** et **intégration native avec Docker**.
- Répartition de charge et haute disponibilité permettant d’assurer **une continuité de service**.

### 9.6 Gestion de Projet : **ClickUp**

- **Outil tout-en-un** combinant gestion des tâches, suivi des bugs, et planification.
- Interface personnalisable avec différentes vues (**Kanban, Gantt, Calendrier**), facilitant l’organisation de l’équipe.
- Version gratuite offrant **de nombreuses fonctionnalités**, adaptée aux besoins de l’équipe.

## 10. Préconisation des Solutions (C1.6)
