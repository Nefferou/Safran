import 'dart:collection';
import 'dart:math';

import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/drawPositionEnum.dart';
import 'package:safran/models/player.dart';

import 'card/card.dart';
import 'card/cardFactory.dart';

class Game {
  late bool isSetup;
  late bool playOrder;
  late bool battleMode;
  late bool isInPause;
  late bool isGameOver;
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
    isInPause = false;
    isGameOver = false;
    battleField = new BattleField();
    cardFactory = new CardFactory(this);

    dealCards(cardFactory.createDeck(3, 21, 15, 10));

    isSetup = true;
  }

  // Deal cards to players and initialize battle field
  dealCards(List<Card> deck) {
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

  play(Player player) {
    // Choose a random player to start
    currentPlayerTurn = Random().nextInt(players.length);

    // Start the game loop
    while (!isGameOver) {
      // Check if the game is over
      if (nbPlayerAlive() <= 1) {
        isGameOver = true;
      }

      // Take the turn of the current player
      players[currentPlayerTurn].takeTurn(this);

      // Set the next player to play
      nextTurn();
    }
  }

  nextTurn() {
    if (playOrder) {
      currentPlayerTurn = (currentPlayerTurn + 1) % players.length;
    } else {
      currentPlayerTurn = (currentPlayerTurn - 1 + players.length) % players.length;
    }
  }

  takeCardToPlayer(Player player) {
    Card takenCard = player.takeRandomCard();
    return takenCard;
  }

  takeCardToBattleField(BattleField battleField, DrawPositionEnum drawPosition) {
    switch (drawPosition) {
      case DrawPositionEnum.TOP:
        return battleField.takeUpCard();
      case DrawPositionEnum.BOTTOM:
        return battleField.takeDownCard();
      case DrawPositionEnum.BOTH:
        return battleField.takeBothCards();
    }
  }

  giveCardToPlayer(Player player, List<Card> cards) {
    player.deck.addAll(cards);
  }

  giveCardToBattleField(BattleField battleField, List<Card> cards) {
    battleField.cards.addAll(cards);
  }

  transferCardPlayerToBattleField(int player, BattleField battleField) {
    List<Card> cards = takeCardToPlayer(players[player]);
    giveCardToBattleField(battleField, cards);
  }

  transferCardPlayerToPlayer(int player1, int player2) {
    List<Card> cards = takeCardToPlayer(players[player1]);
    giveCardToPlayer(players[player2], cards);
  }

  transferCardBattleFieldToPlayer(BattleField battleField, int player, DrawPositionEnum drawPosition) {
    List<Card> cards = takeCardToBattleField(battleField, drawPosition);
    giveCardToPlayer(players[player], cards);
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

  pauseGame() {
    isInPause = !isInPause;
  }

  nbPlayerAlive() {
    int count = 0;
    for (int i = 0; i < players.length; i++) {
      if (players[i].isAlive) {
        count++;
      }
    }
    return count;
  }
}
