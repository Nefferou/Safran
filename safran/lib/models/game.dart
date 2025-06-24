import 'dart:io';
import 'dart:math';
import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';
import 'package:safran/models/logger.dart';
import 'package:safran/models/player.dart';
import 'card/game_card.dart';
import 'card/card_factory.dart';

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

  // Play the game
  play([int playerTurn = -1]) async {
    // Choose a player to start or randomly select one if not specified
    currentPlayerTurn =
        (playerTurn == -1) ? Random().nextInt(players.length) : playerTurn;

    players[currentPlayerTurn].isTheirTurn = true;
    Logger.info(
        "Player ${players[currentPlayerTurn].userName} starts the game");

    // Start the game loop
    while (!isGameOver) {
      final currentPlayer = players[currentPlayerTurn];

      // Pause the game if isInPause is true
      if (currentPlayer.isInPause) {
        sleep(Duration(seconds: 10));
        currentPlayer.timeInPause += 10;
        if (currentPlayer.timeInPause >= 30) {
          kill(currentPlayer, true);
        }
        nextTurn();
        continue;
      }

      // Game is over if only one player is left alive
      if (getNbPlayerAlive() <= 1) {
        isGameOver = true;
        Logger.info("Game is over! Only one player is left alive.");
        break;
      }

      // Skip turn if the player is not alive
      if (!currentPlayer.isAlive) {
        nextTurn();
        continue;
      }

      // Discard a card if the player has the Famine Knight card
      if (currentPlayer.haveFamineKnightCard()) {
        // TODO: Gérer la défausse d'une carte
      }

      // Check if player can play a card
      if (currentPlayer.isTheirTurn) {
        currentPlayer.play(this);
      }

      // Eliminate the player if they have no cards left
      if (currentPlayer.deck.isEmpty) {
        kill(currentPlayer);
      }

      // Set the next player to play
      nextTurn();
    }
    Logger.info("${players[currentPlayerTurn].userName} wins !");
  }

  kill(Player player, [bool isTimeOut = false]) {
    // If the player has the Conquest Knight card and all players are alive (win)
    if (player.deck.contains(ConquestKnightCard()) &&
        allPlayerAlive() &&
        !isTimeOut) {
      Logger.info("${player.userName} has no more cards, he wins by conquest!");

      /// TODO : Player win with conquest
    }
    // If the player is time out 3 times, they are eliminated
    else if (isTimeOut) {
      Logger.info("${player.userName} is time out, he is eliminated");
      player.discardAllCard(this);
      player.isAlive = false;
    }
    // If the player has no more cards, they are eliminated
    else {
      Logger.info("${player.userName} has no more cards, he is eliminated");
      player.isAlive = false;
    }
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

  /*
  conquestWin(int playerIndex) {
    players
        .where((player) => player != players[playerIndex])
        .forEach((player) => player.kill());
  }*/

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
