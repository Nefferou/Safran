import 'dart:math';

import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/draw_position_enum.dart';
import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';
import 'package:safran/models/logger.dart';
import 'package:safran/models/player.dart';

import 'card/game_card.dart';
import 'card/card_factory.dart';
import 'card/triad/cursedKnight/famineKnightCard.dart';
import 'card/triad/cursedKnight/plagueKnightCard.dart';

class Game {
  late bool isSetup;
  late bool playOrder;
  late bool battleMode;
  late bool isInPause;
  late bool isGameOver;
  late int currentPlayerTurn;
  late int nbCardGame;
  late BattleField battleField;
  late CardFactory cardFactory;

  bool testingMode = false;

  // List of players 3-6
  List<Player> players = [];

  // Constructor
  Game(this.players) {
    if (players.length < 3 || players.length > 6) {
      throw Exception(
          "Invalid number of players (3-6), Actual: ${players.length}");
    }
    currentPlayerTurn = -1;
    isSetup = false;
  }

  // Set up game
  setUpGame(int playerTurn) {
    playOrder = true;
    battleMode = false;
    isInPause = false;
    isGameOver = false;
    currentPlayerTurn = playerTurn;
    battleField = BattleField();
    cardFactory = CardFactory(this);

    nbCardGame = 61;
    dealCards(cardFactory.createDeck(3, 21, 15, 10));

    isSetup = true;
  }

  // Deal cards to players and initialize battle field
  dealCards(List<GameCard> deck) {
    try {
      // Check if the deck is empty
      if (deck.isEmpty) {
        throw Exception("Deck is empty");
      }

      // Check if the deck size is valid
      if (deck.length % players.length != 1 ||
          deck.length < players.length + 1) {
        throw Exception(
            "Deck size is not valid. It must be divisible by the number of players plus one for the battle field card.");
      }

      deck.shuffle();

      // Distribute cards to players
      while (deck.length > 1) {
        for (int i = 0; i < players.length; i++) {
          players[i].deck.add(deck.removeLast());
        }
      }

      // Take the last card for the battle field
      battleField.cards.add(deck.removeLast());
    } catch (e) {
      Logger.error("Error while dealing cards: $e");
      rethrow;
    }
  }

  // Check if the cards are equally distributed among players
  checkIfCardIsEqualyDistributed() {
    double expectedCardCount = (nbCardGame - 1) / players.length;

    for (int i = 0; i < players.length; i++) {
      if (players[i].deck.length != expectedCardCount.toInt()) {
        return false;
      }
    }
    return true;
  }

  // Play the game
  play(Player player) {
    // Choose a random player to start
    currentPlayerTurn = Random().nextInt(players.length);
    players[currentPlayerTurn].isTheirTurn = true;
    Logger.info(
        "Player ${players[currentPlayerTurn].userName} starts the game");

    // Start the game loop
    while (!isGameOver) {
      // Check if the game is over
      if (getNbPlayerAlive() <= 1) {
        isGameOver = true;
        Logger.info("Game is over!");
      }

      // Check if player is alive
      if (!players[currentPlayerTurn].isAlive) {
        nextTurn();
        continue;
      }

      // Check if player have Famine Knight Card
      if (getCurrentPlayer().haveFamineKnightCard()) {
        /// TODO : Player choose a card to discard
      }

      // Take the turn of the current player
      getCurrentPlayer().play(this);

      // Check if the current player is still alive
      if (getCurrentPlayer().deck.isEmpty) {
        kill(getCurrentPlayer());
      }

      // Set the next player to play
      nextTurn();
    }
  }

  kill(Player player) {
    if (player.deck.contains(ConquestKnightCard()) && allPlayerAlive()) {
      Logger.info(
          "${player.userName} has no more cards, he wins by conquest!");

      /// TODO : Player win with conquest
    } else {
      Logger.info(
          "${player.userName} has no more cards, he is eliminated");

      /// TODO : Player is eliminated and all his cards are discarded
    }
    player.isAlive = false;
  }

  // Give the turn to the next player
  nextTurn() {
    players[currentPlayerTurn].isTheirTurn = false;
    if (playOrder) {
      currentPlayerTurn = (currentPlayerTurn + 1) % players.length;
    } else {
      currentPlayerTurn =
          (currentPlayerTurn - 1 + players.length) % players.length;
    }
    players[currentPlayerTurn].isTheirTurn = true;
  }

  // Get the Next / Previous / Current player index to play
  getNextPlayerTurn() {
    if (playOrder) {
      return players[(currentPlayerTurn + 1) % players.length];
    } else {
      return players[(currentPlayerTurn - 1 + players.length) % players.length];
    }
  }

  Player getPreviousPlayerTurn() {
    if (playOrder) {
      return players[(currentPlayerTurn - 1 + players.length) % players.length];
    } else {
      return players[(currentPlayerTurn + 1) % players.length];
    }
  }

  // Change state of the game
  changePlayOrder() {
    playOrder = !playOrder;
  }

  changePauseGame() {
    isInPause = !isInPause;
  }

  /*
  conquestWin(int playerIndex) {
    players
        .where((player) => player != players[playerIndex])
        .forEach((player) => player.kill());
  }*/

  allPlayerAlive() {
    return players.every((player) => player.isAlive);
  }

  // Setters and Getters
  getBattleField() {
    return battleField;
  }

  getNbPlayerAlive() {
    int count = 0;
    for (int i = 0; i < players.length; i++) {
      if (players[i].isAlive) {
        count++;
      }
    }
    return count;
  }

  getPlayerWithWarKnight() {
    for (var player in players) {
      if (player.haveWarKnightCard()) return player;
    }
    return null;
  }

  getPlayerIndexWithConquestKnight() {
    return players.indexWhere((player) => player.haveConquestKnightCard());
  }

  Player getCurrentPlayer() {
    return players[currentPlayerTurn];
  }

  getCurrentPlayerIndex() {
    return currentPlayerTurn;
  }

  getPlayer(int index) {
    return players[index];
  }

  setBattleMode(bool battleMode) {
    this.battleMode = battleMode;
  }

  setFactory(CardFactory cardFactory) {
    this.cardFactory = cardFactory;
  }
}
