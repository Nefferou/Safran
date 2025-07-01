import 'dart:io';
import 'dart:math';
import 'package:safran/entities/battle_field.dart';
import 'package:safran/core/constants/player_status_constant.dart';
import 'package:safran/services/logger.dart';
import 'package:safran/entities/player.dart';
import '../entities/card/game_card.dart';
import '../services/card_factory.dart';

class Game {
  late bool isSetup;
  late bool playOrder;
  late bool battleMode;
  late bool isInPause;
  late bool isGameOver;
  late int currentPlayerTurn;
  late int nbCardGame;
  late int nbPlayerDieInARow;
  late BattleField battleField;
  late CardFactory cardFactory;

  String winCondition = "No win condition set";

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
    nbPlayerDieInARow = 0;
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
            "Deck size is not valid. It must be divisible by the number of players plus one for the battle field card");
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

      if (!checkIfCardIsEquallyDistributed()) {
        throw Exception("Cards are not equally distributed among players");
      }
    } catch (e) {
      Logger.error("Error while dealing cards: $e");
      rethrow;
    }
  }

  // Check if the cards are equally distributed among players
  checkIfCardIsEquallyDistributed() {
    double expectedCardCount = (nbCardGame - 1) / players.length;

    for (int i = 0; i < players.length; i++) {
      if (players[i].deck.length != expectedCardCount.toInt()) {
        return false;
      }
    }
    return true;
  }

  // Start the game
  startGame([int playerTurn = -1]) {
    // Choose a player to start or randomly select one if not specified
    currentPlayerTurn =
        (playerTurn == -1) ? Random().nextInt(players.length) : playerTurn;

    players[currentPlayerTurn].isTheirTurn = true;
    Logger.info(
        "Player ${players[currentPlayerTurn].userName} starts the game");

    playGame();

    Logger.info("${players[currentPlayerTurn].userName} wins ! $winCondition");
  }

  void playGame() {
    while (!isGameOver) {
      final currentPlayer = players[currentPlayerTurn];

      if (handlePauseIfNeeded(currentPlayer)) continue;
      if (checkEndGame()) break;
      if (skipIfDead(currentPlayer)) continue;

      handleFamineKnight(currentPlayer);
      playTurn(currentPlayer);
      eliminateAllPlayersWithoutCards();
      handleConquestKnight();

      nextTurn();
    }
  }

  kill(Player player, [bool isTimeOut = false]) {
    // If the player has the Conquest Knight card and all players are alive (win)
    if (player.status == PlayerStatusConstant.conquest &&
        !onePlayerIsDead() &&
        !isTimeOut) {
      Logger.info("${player.userName} has no more cards, he wins by conquest!");

      for (player in getOtherAlivePlayers()) {
        player.discardAllCard(this);
        player.status = PlayerStatusConstant.dead;
      }

      isGameOver = true;
      winCondition = "Wins by conquest";
    }
    // If the player is time out 3 times, they are eliminated
    else if (isTimeOut) {
      Logger.info("${player.userName} is time out, he is eliminated");
      player.discardAllCard(this);
      player.status = PlayerStatusConstant.timeout;
    }
    // If the player has no more cards, they are eliminated
    else {
      Logger.info("${player.userName} has no more cards, he is eliminated");
      player.status = PlayerStatusConstant.dead;
    }
    nbPlayerDieInARow++;
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

  bool handlePauseIfNeeded(Player currentPlayer) {
    while (currentPlayer.isInPause) {
      sleep(const Duration(seconds: 1));
      currentPlayer.timeInPause += 1;

      if (currentPlayer.timeInPause >= 30) {
        kill(currentPlayer, true);
        nextTurn();
        return true;
      }
    }
    return false;
  }

  bool checkEndGame() {
    // One player left alive
    if (getNbPlayerAlive() == 1) {
      isGameOver = true;
      Logger.info("Game is over!");
      winCondition = "Only one player is left alive";
      return true;
    }

    // Zero player left alive
    if (getNbPlayerAlive() == 0) {
      isGameOver = true;
      Logger.info("Draw: $nbPlayerDieInARow players eliminated in a row.");
      winCondition =
          "Draw: $nbPlayerDieInARow players eliminated after a chain of deaths";
      return true;
    }

    // The game is not over yet
    nbPlayerDieInARow = 0;
    return false;
  }

  bool skipIfDead(Player player) {
    if (player.status == PlayerStatusConstant.dead ||
        player.status == PlayerStatusConstant.timeout) {
      nextTurn();
      return true;
    }
    return false;
  }

  void handleFamineKnight(Player player) {
    if (player.haveFamineKnightCard()) {
      player.discardCard(this);
    }
  }

  void handleConquestKnight() {
    for (var player in players) {
      if (player.haveConquestKnightCard() && onePlayerIsDead()) {
        kill(player);
      }
    }
  }

  void playTurn(Player player) {
    if (player.isTheirTurn) {
      player.play(this);
    }
  }

  void eliminateAllPlayersWithoutCards() {
    for (var player in players) {
      if (isAlive(player) && player.deck.isEmpty) {
        kill(player);
      }
    }
  }

  bool isAlive(Player player) =>
      player.status == PlayerStatusConstant.alive ||
      player.status == PlayerStatusConstant.conquest;

  // Get the Next / Previous / Current player index to play
  getNextPlayerTurnIndex() {
    if (playOrder) {
      return (currentPlayerTurn + 1) % players.length;
    } else {
      return (currentPlayerTurn - 1 + players.length) % players.length;
    }
  }

  getPreviousPlayerTurnIndex() {
    if (playOrder) {
      return (currentPlayerTurn - 1 + players.length) % players.length;
    } else {
      return (currentPlayerTurn + 1) % players.length;
    }
  }

  // Change state of the game
  changePlayOrder() {
    playOrder = !playOrder;
  }

  getNbPlayerAlive() {
    int count = 0;
    for (int i = 0; i < players.length; i++) {
      if (players[i].status == PlayerStatusConstant.alive) {
        count++;
      }
    }
    return count;
  }

  onePlayerIsDead() {
    return players
        .where((player) => player.status == PlayerStatusConstant.dead)
        .isNotEmpty;
  }

  List<Player> getOtherAlivePlayers() {
    return players
        .where((player) =>
            player.status == PlayerStatusConstant.alive &&
            player != players[currentPlayerTurn])
        .toList();
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
}
