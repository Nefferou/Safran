import 'dart:collection';
import 'dart:math';

import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/drawPositionEnum.dart';
import 'package:safran/models/player.dart';

import 'card/card_game.dart';
import 'card/cardFactory.dart';

class Game {
  late bool isSetup;
  late bool playOrder;
  late bool battleMode;
  late int currentPlayerTurn;
  late BattleField battleField;
  late CardFactory cardFactory;

  // List of players 3-6
  List<Player> players = [];

  // Constructor
  Game(this.players) {
    if (players.length < 3 || players.length > 6) {
      throw new Exception(
          "Invalid number of players (3-6), Actual: ${players.length}");
    }
    currentPlayerTurn = -1;
    isSetup = false;
  }

  // Set up game
  setUpGame() {
    playOrder = true;
    battleMode = false;
    battleField = BattleField();
    cardFactory = CardFactory(this);

    dealCards(cardFactory.createDeck(3, 21, 15, 10));

    isSetup = true;
  }

  // Deal cards to players and initialize battle field
  dealCards(List<GameCard> deck) {
    deck.shuffle();
    int playerCount = players.length;

    while (deck.length > 1) {
      for (int i = 0; i < playerCount; i++) {
        players[i].deck.add(deck.removeLast());
      }
    }

    battleField.cards.add(deck.removeLast());

    if (deck.isNotEmpty) {
      throw new Exception("Deck not empty");
    } else if (!checkIfCardIsEqualyDistributed()) {
      throw new Exception("Cards not equally distributed");
    }
  }

  takeTurn(Player player) {
    /// TODO
  }

  takeCardToPlayer(Player player) {
    GameCard takenCard = player.takeRandomCard();
    return takenCard;
  }

  takeCardToBattleField(
      BattleField battleField, DrawPositionEnum drawPosition) {
    switch (drawPosition) {
      case DrawPositionEnum.TOP:
        return battleField.takeUpCard();
      case DrawPositionEnum.BOTTOM:
        return battleField.takeDownCard();
      case DrawPositionEnum.BOTH:
        return battleField.takeBothCards();
    }
  }

  giveCardToPlayer(Player player, List<GameCard> cards) {
    player.deck.addAll(cards);
  }

  giveCardToBattleField(BattleField battleField, List<GameCard> cards) {
    battleField.cards.addAll(cards);
  }

  transferCardPlayerToBattleField(Player player, BattleField battleField) {
    List<GameCard> cards = takeCardToPlayer(player);
    giveCardToBattleField(battleField, cards);
  }

  transferCardPlayerToPlayer(Player player1, Player player2) {
    List<GameCard> cards = takeCardToPlayer(player1);
    giveCardToPlayer(player2, cards);
  }

  transferCardBattleFieldToPlayer(
      BattleField battleField, Player player, DrawPositionEnum drawPosition) {
    List<GameCard> cards = takeCardToBattleField(battleField, drawPosition);
    giveCardToPlayer(player, cards);
  }

  checkIfCardIsEqualyDistributed() {
    int playerCount = players.length;
    int expectedCardCount = 61 ~/ playerCount;

    for (int i = 0; i < playerCount; i++) {
      if (players[i].deck.length != expectedCardCount) {
        return false;
      }
    }
    return true;
  }

  changePlayOrder() {
    playOrder = !playOrder;
  }

  setFactory(CardFactory cardFactory) {
    this.cardFactory = cardFactory;
  }
}
