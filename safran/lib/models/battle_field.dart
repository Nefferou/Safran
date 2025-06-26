import 'dart:collection';
import 'card/game_card.dart';

class BattleField {
  late Queue<GameCard> cards;

  BattleField() {
    cards = Queue<GameCard>();
  }

  takeUpCard() {
    return [cards.removeLast()];
  }

  takeDownCard() {
    return [cards.removeFirst()];
  }

  takeBothCards() {
    return [cards.removeFirst(), cards.removeLast()];
  }

  shuffleBattleField() {
    List<GameCard> cardsList = cards.toList();
    cardsList.shuffle();
    cards = Queue.from(cardsList);
  }

  getUpCard() {
    return cards.last;
  }

  getLength() {
    return cards.length;
  }
}