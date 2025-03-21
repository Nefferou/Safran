import 'dart:math';

import 'package:flutter/material.dart';

class Player {

  String userName;
  bool isAlive;

  List<Card> deck = [];

  Player(this.userName)
      : isAlive = true;

  kill() {
    isAlive = false;
  }

  addCard(Card card) {
    deck.add(card);
  }

  chooseCard(int index) {
    return deck[index];
  }

  removeRandomCard() {
    int deckLength = deck.length;
    int randomIndex = Random().nextInt(deckLength);

    deck.removeAt(randomIndex);
  }

  removeChosenCard(Card card) {
    deck.remove(card);
  }
}