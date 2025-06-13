# Scénario de test

## Cas de test 1 : Tour de jeu complet
Chaque joueur joue un tour complet, en commençant par le joueur 1, puis le joueur 2, etc. jusqu'au joueur 4. 
Le joueur 1 commence la partie.

## Cas de test 2 : Fin de partie
La partie se termine lorsque tous les joueurs (sauf 1) n'ont plus de carte. 
Le joueur restant est déclaré vainqueur.

## Cas de test 3 : Fin de partie avec Cavalier de la conquête
La partie se termine lorsque le joueur ayant le Cavalier de la conquête perd en 1er.

## Cas de test 4 : Pioche une carte en cas de champs de bataille vide
Si le champ de bataille est vide, les cartes permettant de piocher une carte sont ignorées.

## Cas de test 5 : Choisir un joueur pour piocher une carte
Si le joueur 1 joue un mage, il peut choisir un joueur pour piocher une carte.

## Cas de test 6 : Choisir un joueur pour voler une carte à un autre joueur
Si le joueur 1 joue un voleur, il peut choisir un joueur pour voler une carte à un autre joueur.

## Cas de test 7 : Défaite d'un joueur avec le Cavalier de la mort
Si un joueur perd avec le Cavalier de la mort, il est éliminé de la partie.

## Cas de test 8 : Défaite d'un joueur avec le Cavalier de la conquête
Si un joueur perd avant le possesseur du Cavalier de la conquête, le possesseur du Cavalier de la conquête est éliminé de la partie.

## Cas de test 9 : Défaite d'un joueur par manque de cartes
Si un joueur n'a plus de cartes, il est éliminé de la partie.

## Cas de test 10 : Impossible de jouer un Cavalier si d'autres cartes sont possédées
Si un joueur possède des cartes autres que les Cavaliers, il ne peut pas jouer un Cavalier.

## Cas de test 11 : Jouer un Cavalier en n'en possédant plusieurs
Si un joueur possède plusieurs Cavaliers et qu'il n'a plus d'autres cartes, il peut en jouer un.

## Cas de test 12 : Victoire avec le Cavalier de la conquête grâce au Cavalier de la mort
Si un joueur se fait piocher le Cavalier de la mort et qu'il a le Cavalier de la conquête

## Cas de test 13 : Piocher le Cavalier de la conquête et qu'il y a déjà eu des joueurs éliminés
Si un joueur pioche le cavalier de la conquête celui ci ne doit plus rien faire

## Cas de test 14 : Défausser des cartes à cause du Cavalier de la famine
Si un joueur à le cavalier de la famine il doit défausser une carte à chacun de ces tour

## Cas de test 15 : Défausser des cartes à cause dU Cavalier de la guerre
si un joueur défausse une carte alors le joueur avec le Cavalier de la guerre le défausse