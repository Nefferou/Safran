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

| **Risques**                                                           | **Criticité** | **Impact**                            | **Mesures d'atténuation**                                                                |
|-----------------------------------------------------------------------|---------------|---------------------------------------|------------------------------------------------------------------------------------------|
| Règles du jeu mal comprises par les utilisateurs                      | Moyenne       | Abandon précoce du jeu                | Tutoriels interactifs et explications claires                                            |
| Manque d’engagement des joueurs à long terme                          | Élevée        | Baisse de la rétention utilisateur    | Ajout de contenus évolutifs et de modes spéciaux                                         |
| Dépendance aux plateformes de distribution (Google Play, App Store)   | Critique      | Risque de suppression ou restrictions | Diversification des canaux de distribution et respect des guidelines                     |
| Difficulté d’adoption du jeu en raison de la forte concurrence        | Élevée        | Faible adoption                       | Stratégie marketing ciblée, publication sur les réseaux et partenariats                  |
| Non-conformité aux réglementations sur la confidentialité des données | Critique      | Sanctions légales                     | Respect des normes RGPD et mise en place d’une politique de confidentialité transparente |

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

## 9. Estimation de la Charge de Travail et du Budget (C1.4.1, C1.4.2)
### 9.1 Charge de travail

## 10. Préconisation des Solutions (C1.6)
