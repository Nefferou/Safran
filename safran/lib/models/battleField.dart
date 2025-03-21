import 'dart:collection';
import 'card/card.dart';

class BattleField {
  late Queue<Card> cards;

  BattleField() {
    cards = Queue<Card>();
  }

  takeUpCard() {
    return cards.removeFirst();
  }

  takeDownCard() {
    return cards.removeLast();
  }

  takeBothCards() {
    return [cards.removeFirst(), cards.removeLast()];
  }

  shuffleBattleField() {
    List<Card> cardsList = cards.toList();
    cardsList.shuffle();
    cards = Queue.from(cardsList);
  }

  getCards() {
    return cards;
  }

  getLength() {
    return cards.length;
  }
}