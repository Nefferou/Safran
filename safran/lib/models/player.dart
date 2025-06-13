import 'dart:collection';
import 'dart:math';

import 'card/card_game.dart';


class Player {

  String userName;
  bool isAlive;

  List<GameCard> deck = [];

  Player(this.userName)
      : isAlive = true;

  kill() {
    isAlive = false;
  }

  takeRandomCard() {
    int deckLength = deck.length;
    int randomIndex = Random().nextInt(deckLength);

    GameCard card = deck.elementAt(randomIndex);
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
}