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

## 8. Étude Comparative des Solutions Techniques (C1.3.2)
### Front
#### Flutter
##### Description
Flutter est un framework open-source développé par Google permettant de créer des applications mobiles à partir d'un code unique en Dart. Il utilise son propre moteur de rendu pour offrir des interfaces fluides et personnalisables.

##### Aventage
Code multiplateformes (iOS, Android, ...),\
Performances élevées grâce à son moteur de rendu natif,\
Interface personnalisable avec des widgets flexibles et modernes,\
Large communauté et support de Google,\
Hot Reload pour un développement rapide et interactif.

##### Inconvénien
Poids des applications plus élevé que les solutions natives,\
Accès aux fonctionnalités natives parfois limité, nécessitant des plugins tiers.

#### React Native
##### Description
React Native est le langage de programmation principal pour le développement d'applications mobiles, une plateforme populaire pour créer des applications mobiles multiplateformes.

##### Aventage
Grande communauté de développeurs,\
Code multiplateformes (iOS, Android, ...),\
Développement rapide avec des mises à jour en temps réel via le Hot Reload.

##### Inconvénien
Peut présenter des limitations en termes de performances par rapport au développement natif.

#### Kotlin
##### Description
Kotlin est un langage moderne pour le développement Android.

##### Aventage
Kotlin offre une syntaxe concise et peu verbeuse,\
Prise en charge officielle de Google pour le développement Android.

##### Inconvénien
Grande courbe d'apprentissage pour Kotlin pour les développeurs,\
Code non-multiplateformes.

#### Swift
##### Description
Swift est le langage de programmation développé par Apple pour le développement d'applications iOS et macOS.

##### Aventage
Offre des performances élevées,\
Syntaxe moderne et expressive,\
Prises en charge officielles par Apple,\
Sécurité accrue par rapport à Objective-C.

##### Inconvénien
Grande courbe d'apprentissage pour les développeurs venant d'autres langages,\
Développement limité à l'écosystème Apple

#### Xamarin
##### Description
Xamarin est un framework open-source de c# développé par Microsoft pour créer des applications mobiles multiplateformes.

##### Aventage
Accès complet aux fonctionnalités natives des plateformes,\
Performances élevées,\
Intégration étroite avec les outils Microsoft et .NET.

##### Inconvénien
Grande courbe d'apprentissage pour les développeurs nouveaux à C# et Xamarin,\
Certaines fonctionnalités peuvent nécessiter des extensions tierces payantes.

### Back
#### Express
##### Description
Framework minimaliste et flexible de Node.js. Il est léger, simple à utiliser et dispose d'une large communauté.

##### Aventage
Fonctionne très bien avec les applications en temps réel,\
Large écosystème de modules,\
Facile à apprendre et mise en place rapide.

##### Inconvénien
Difficulté sur les calcul complexe parce qu'il réquisitionne une grande partie du CPU,\
pas de typage fort

#### Flask
##### Description
Framework python minimaliste et léger, facile à configurer

##### Aventage
Simple à prendre en main,\
Très bon sur les petits projets,\
Flexible.

##### Inconvénien
Difficulté sur les projets complexe,\
Rencontre très vite des problèmes de performance.

#### Spring Boot
##### Description
Framework Java, conçu pour développer des API REST performantes et sécurisées

##### Aventage
Très bonne gestion de la sécurité,\
possède une grande communauté,\
Scalable.

##### Inconvénien
Grande courbe d'apprentissage,\
Temp de développement plus long.

#### Go
##### Description
Go, développé par Google, est un langage compilé conçu pour la performance et la scalabilité, idéal pour les applications nécessitant de la concurrence et de la faible latence.

##### Aventage
Excellente gestion de la concurrence grâce aux Goroutines,\
Très performant et peu gourmand en ressources,\
Facile à déployer avec un exécutable unique.

##### Inconvénien
Peu de bibliothèques et d’outils,\
Syntaxe stricte qui peut être difficile à prendre en main au début.

#### Rust
##### Description
Rust est un langage système moderne qui met l’accent sur la performance, la sécurité et la gestion efficace de la mémoire.

##### Aventage
Très haute performance, proche du C/C++,\
Sécurité mémoire garantie, évitant les erreurs courantes (pointeurs nuls, débordements de mémoire),\
Idéal pour des applications à faible latence comme un serveur de jeu en temps réel.

##### Inconvénien
Courbe d’apprentissage élevée, syntaxe complexe,\
Ecosystème jeune, avec peu de bibliothèques.

### Monitoring
#### Prometheus
##### Description
Outil open-source de monitoring et d’alerte, idéal pour collecter et analyser des métriques système et applicatives en temps réel.

##### Aventage
Très performant pour collecter un grand volume de données,\
Intégration facile avec Grafana pour la visualisation,\
Système d’alertes avancé.

##### Inconvénien
Stockage limité (conçu pour du court terme).
Grande courbe d’apprentissage pour les requêtes PromQL.

#### Grafana
##### Description
Plateforme de visualisation et d’analyse de métriques.

##### Aventage
Interface graphique intuitive et personnalisable,\
Supporte plusieurs sources de données,\
Alertes et dashboards interactifs.

##### Inconvénien
Dépend d’une source de données externe,\
Configuration avancée peut être complexe.

#### New Relic
##### Description
Solution cloud de monitoring des performances applicatives (APM) avec analyse en temps réel.

##### Aventage
Monitoring complet (serveur, application, base de données),\
Facile à intégrer avec les services cloud,\
Excellente visualisation des performances et logs.

##### Inconvénien
Coût élevé pour des applications à fort trafic,\
Peut être trop complexe pour une petite équipe.

#### Datadog
##### Description
Plateforme tout-en-un pour le monitoring, l’analyse des logs et la sécurité des applications.

##### Aventage
Supporte de nombreux langages et environnements (Node.js, Python, Go…),\
Alertes avancées et tableaux de bord interactifs,\
Suivi des logs et des erreurs en temps réel.

##### Inconvénien
Abonnement payant, avec un coût qui peut vite grimper,\
Peut être trop puissant pour un petit projet.

#### Zabbix
##### Description
Outil open-source de monitoring réseau et serveur, adapté aux infrastructures complexes.

##### Aventage
Solution gratuite et open-source,\
Supervision complète des serveurs et bases de données,\
Gestion avancée des alertes.

##### Inconvénien
Interface peu intuitive,\
Nécessite un serveur dédié pour stocker les données.

### Base de donnée
#### PostgreSQL
##### Description
Base de données relationnelle robuste et open-source, idéale pour stocker des données structurées.

##### Aventage
Fiable et sécurisé, avec une bonne gestion des transactions,\
Performant pour les requêtes complexes,\
Compatible avec de nombreux langages.

##### Inconvénien
Moins adapté pour gérer de gros volumes de données non structurées,\
Configuration et optimisation peuvent être complexes.

#### MongoDB
##### Description
Base de données NoSQL orientée documents, idéale pour stocker des données flexibles.

##### Aventage
Flexible et évolutif, parfait pour des données non structurées,\
Performant pour des requêtes rapides sur de gros volumes de données,\
Facile à scaler horizontalement.

##### Inconvénien
Moins adapté aux transactions complexes,\
Consommation mémoire plutôt élevée.

#### MySQL
##### Description
MySQL est une base de données relationnelle open-source très populaire. Elle est adaptée pour gérer les données structurées.

##### Aventage
Facilité d'utilisation et large communauté,\
Performances élevées pour les applications avec des requêtes SQL standard,\
Excellente gestion des transactions (ACID), garantissant l'intégrité des données,\
Supporte le partitionnement et le clustering, utile pour la scalabilité.

##### Inconvénien
Manque de fonctionnalités avancées,\
Peut nécessiter une configuration supplémentaire pour des performances optimales sous forte charge.

### Devops
#### Kubernetes
##### Description
Kubernetes est une plateforme open-source permettant d’automatiser le déploiement, la gestion et la scalabilité des applications conteneurisées

##### Aventage
Scalabilité automatique des ressources en fonction de la charge,\
Haute disponibilité grâce à la répartition des charges,\
Compatible avec le cloud (AWS, GCP, Azure) et les infrastructures on-premise.

##### Inconvénien
Complexe à mettre en place et à configurer,\
Consommation de ressources élevée.

#### Docker + Docker Swarm
##### Description
Docker permet de packager l’application et ses dépendances dans des conteneurs, et Docker Swarm facilite leur orchestration de manière simple.

##### Aventage
Facile à mettre en place pour un projet de taille moyenne,\
Isolation des environnements,\
Simple, tout en offrant une orchestration basique.

##### Inconvénien
Peu robuste et évolutif pour une application à fort trafic,\
Peu d’outils natifs pour la gestion avancée du monitoring et du scaling.

#### Jenkins
##### Description
Jenkins est un outil open-source permettant d’automatiser les tests, les builds et le déploiement de l’application.

##### Aventage
Automatisation des tests et des déploiements,\
Personnalisable avec de nombreux plugins,\
Compatible avec presque tous les langages et plateformes.

##### Inconvénien
Peut être complexe à configurer avec de nombreux plugins,\
Nécessite une maintenance régulière pour éviter les problèmes de performance.

### Logiciel de gestion
#### ClickUp
##### Description
ClickUp est un outil de gestion de projet tout-en-un qui permet de suivre les tâches, organiser les projets, collaborer en équipe et automatiser les processus. Il est flexible et peut s’adapter à diverses méthodologies (Agile, Cascade, etc.).

##### Aventage
Outil tout-en-un : gestion de tâches, suivi des bugs, gestion du temps, et documentation,\
Personnalisable à 100%, avec des vues Kanban, Gantt, Calendrier, etc,\
Automatisations avancées.

##### Inconvénien
Peut devenir complexe en raison de nombreuses fonctionnalités,\
La version gratuite est limitée, certaines fonctionnalités clés nécessitent un abonnement payant.

#### Trello
##### Description
Trello est un outil de gestion de projet basé sur un système de tableaux, listes et cartes permettant d’organiser les tâches de manière visuelle.

##### Aventage
Interface simple et intuitive,\
Idéal pour la gestion agile,\
Version gratuite suffisante pour les petits projets.

##### Inconvénien
Manque de fonctionnalités avancées,\
Difficile à gérer pour les projets complexes avec de nombreuses dépendances.

#### Notion
##### Description
Notion combine gestion de projet et documentation dans un seul outil personnalisable.

##### Aventage
Flexibilité extrême,\
Idéal pour la documentation technique et le suivi des tâches,\
Interface moderne et intuitive.

##### Inconvénien
peut spécialisé dans le suivi des tâches complexes,\
Peut devenir brouillon si mal organisé.

## 9. Estimation de la Charge de Travail et du Budget (C1.4.1, C1.4.2)
### 9.1 Charge de travail

## 10. Préconisation des Solutions (C1.6)
