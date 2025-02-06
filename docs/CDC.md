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

## 10. Préconisation des Solutions (C1.6)
