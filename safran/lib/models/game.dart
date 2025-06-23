import 'dart:math';

import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/constant/cardCreationConstant.dart';
import 'package:safran/models/card/draw_position_enum.dart';
import 'package:safran/models/logger.dart';
import 'package:safran/models/player.dart';

import 'card/game_card.dart';
import 'card/card_factory.dart';
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
    cardFactory =  CardFactory(this);

    int nbPlayers = players.length;

    nbCardGame = 61;
    dealCards(cardFactory.createDeck(3, 21, 15, 10), true);

    isSetup = true;
  }

  // Deal cards to players and initialize battle field
  dealCards(List<GameCard> deck, bool shuffleDeck) {

    // Check if the deck is empty
    if (deck.isEmpty) {
      throw Exception("Deck is empty");
    }

    // Check if the deck size is valid
    if (deck.length % players.length != 1) {
      throw Exception("Deck size must be divisible by the number of players plus one for the battle field card.");
    }

    // Check if the deck must be shuffled
    if (shuffleDeck) {
      deck.shuffle();
    }

    // Distribute cards to players
    while (deck.length > 1) {
      for (int i = 0; i < players.length; i++) {
        players[i].deck.add(deck.removeLast());
      }
    }

    // Initialize the battle field with one card
    battleField.cards.add(deck.removeLast());

    // Check if the deck is empty
    if (deck.isNotEmpty) {
      throw Exception("Deck isn't empty");
    }

    // Check if cards are equally distributed
    if (!checkIfCardIsEqualyDistributed()) {
      throw Exception("Cards not equally distributed");
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
    Logger.info("Player ${players[currentPlayerTurn].userName} starts the game");

    // Start the game loop
    while (!isGameOver) {
      // Check if the game is over
      if (getNbPlayerAlive() <= 1) {
        isGameOver = true;
        Logger.info("Game is over!");
      }

      // Take the turn of the current player
      players[currentPlayerTurn].takeTurn(this);

      // Set the next player to play
      nextTurn();
    }
  }

  // Give the turn to the next player
  nextTurn() {
    if (playOrder) {
      currentPlayerTurn = (currentPlayerTurn + 1) % players.length;
    } else {
      currentPlayerTurn = (currentPlayerTurn - 1 + players.length) % players.length;
    }
  }

  // Get the Next / Previous / Current player index to play
  getNextPlayerTurnIndex() {
    if(playOrder) {
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

  getCurrentPlayerTurnIndex() {
    return currentPlayerTurn;
  }

  // Take Card from player or battle field
  takeCardToPlayer(Player player, int indexCard) {
    GameCard takenCard = player.takeCard(indexCard, this);
    return takenCard;
  }

  takeRandomCardToPlayer(Player player) {
    GameCard takenCard = player.takeRandomCard(this);
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

  // Give Card to player or battle field
  giveCardToPlayer(Player player, List<GameCard> cards) {
    player.deck.addAll(cards);
  }

  giveCardToBattleField(BattleField battleField, List<GameCard> cards) {
    battleField.cards.addAll(cards);
  }

  // Transfer Card from ... to ... (Take and Give)
  transferCardPlayerToBattleField(int player, int indexCard, BattleField battleField) {
    GameCard card = takeCardToPlayer(players[player], indexCard);
    giveCardToBattleField(battleField, [card]);
    Logger.info("Player ${players[player].userName} discard");
  }

  transferCardPlayerToPlayer(int player1, int indexCard, int player2,
      {bool canBeKill = true}) {
    GameCard cards;
    if(indexCard == -1) {
      cards = takeRandomCardToPlayer(players[player1]);
    } else {
      cards = takeCardToPlayer(players[player1], indexCard);
    }

    if(cards.runtimeType == PlagueKnightCard && canBeKill) {
      players[player1].discardAllCard(this, player1);
    }

    giveCardToPlayer(players[player2], [cards]);
    Logger.info("Player ${players[player2].userName} from player ${players[player1].userName}");
  }

  transferCardBattleFieldToPlayer(BattleField battleField, int player, DrawPositionEnum drawPosition) {
    List<GameCard> cards = takeCardToBattleField(battleField, drawPosition);
    giveCardToPlayer(players[player], cards);
    Logger.info("Player ${players[player].userName} draw ${cards.length} card(s)");
  }

  // Change state of the game
  changePlayOrder() {
    playOrder = !playOrder;
  }

  changePauseGame() {
    isInPause = !isInPause;
  }

  conquestWin(int playerIndex) {
    players
        .where((player) => player != players[playerIndex])
        .forEach((player) => player.kill(this));
  }

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