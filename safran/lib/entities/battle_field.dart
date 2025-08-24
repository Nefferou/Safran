import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:safran/services/logger.dart';

import '../entities/card/game_card.dart';

class BattleField  extends ChangeNotifier {
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
    Logger.info("cardList ${cardsList}");
    cards = Queue.from(cardsList);
  }

  void addCards(List<GameCard> newCards) {
    cards.addAll(newCards);
    notifyListeners();
  }

  getUpCard() {
    Logger.info("carte de dessus : ${cards.last}");
    return cards.last;
  }

  getLength() {
    return cards.length;
  }
}