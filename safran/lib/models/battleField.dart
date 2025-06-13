import 'dart:collection';
import 'card/card_game.dart';

class BattleField {
  late Queue<GameCard> cards;

  BattleField() {
    cards = Queue<GameCard>();
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
    List<GameCard> cardsList = cards.toList();
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