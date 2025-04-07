import 'dart:io';
import 'dart:math';

import 'package:safran/models/card/recruitment/mage/mageCard.dart';
import 'package:safran/models/card/recruitment/thielfCard.dart';
import 'package:safran/models/card/triad/fateHerald/fateHeraldCard.dart';

import 'card/card.dart';
import 'game.dart';


class Player {

  String userName;
  bool isAlive;
  bool isTheirTurn;

  List<Card> deck = [];

  Player(this.userName)
      : isAlive = true,
        isTheirTurn = false;

  playCard(Game game, indexCard) {
    if(deck[indexCard] is MageCard || deck[indexCard] is FateHeraldCard) {
      stdout.write("Entrez l'index du joueur : ");
      int indexPlayer = stdin.readLineSync() as int;
      deck[indexCard].play(game, [indexPlayer]);
    } else if(deck[indexCard] is ThielfCard) {
      stdout.write("Entrez l'index du joueur voleur : ");
      int indexPlayer1 = stdin.readLineSync() as int;
      stdout.write("Entrez l'index du joueur volé : ");
      int indexPlayer2 = stdin.readLineSync() as int;
      deck[indexCard].play(game, [indexPlayer1, indexPlayer2]);
    } else {
      deck[indexCard].play(game);
    }
  }

  kill() {
    isAlive = false;
  }

  takeRandomCard() {
    int deckLength = deck.length;
    int randomIndex = Random().nextInt(deckLength);

    Card card = deck.elementAt(randomIndex);
    deck.removeAt(randomIndex);

    return card;
  }

  getName() {
    return userName;
  }

  getDeck() {
    return deck;
  }

  getDeckLength() {
    return deck.length;
  }

  takeTurn(Game game) {
    if(!isAlive) {
      return;
    }

    isTheirTurn = true;
    stdout.write("Entrez l'index de la carte à jouer : ");
    int indexCard = stdin.readLineSync() as int;

    playCard(game, indexCard);

    if(deck.isEmpty) {
      kill();
    }

    isTheirTurn = false;
  }
}