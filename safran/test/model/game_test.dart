import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/battle_field.dart';
import 'package:safran/entities/card/recruitment/army/swordsman_card.dart';
import 'package:safran/services/card_factory.dart';
import 'package:safran/core/constants/player_status_constant.dart';
import 'package:safran/entities/card/game_card.dart';
import 'package:safran/entities/card/recruitment/army/archer_card.dart';
import 'package:safran/entities/card/recruitment/army/guard_card.dart';
import 'package:safran/entities/card/recruitment/commander_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/conquest_knight_card.dart';
import 'package:safran/entities/game.dart';
import 'package:safran/entities/player.dart';

import '../utils/cards_verifier.dart';
import '../utils/fake_card.dart';
import '../utils/fake_player.dart';
import '../utils/preset_util.dart';

void main() {
  late Player playerTest1;
  late Player playerTest2;
  late Player playerTest3;
  late Player playerTest4;
  late Player playerTest5;
  late Player playerTest6;

  late FakePlayer testPlayer1;
  late FakePlayer testPlayer2;
  late FakePlayer testPlayer3;

  late Game canPlayedCardGame;

  setUp(() {
    playerTest1 = Player("PlayerTest1");
    playerTest2 = Player("PlayerTest2");
    playerTest3 = Player("PlayerTest3");
    playerTest4 = Player("PlayerTest4");
    playerTest5 = Player("PlayerTest5");
    playerTest6 = Player("PlayerTest6");

    testPlayer1 = FakePlayer("Player1");
    testPlayer2 = FakePlayer("Player2");
    testPlayer3 = FakePlayer("Player3");

    canPlayedCardGame = PresetUtil.presetCanPlayCard();
  });

  setUpWithNbPlayer(List<Player> players) {
    Game game = Game(players);
    game.setUpGame(0);

    return game;
  }

  group("Game setup tests", () {
    test("Game is created and setup / card is correct deal (3 players)", () {
      Game game = setUpWithNbPlayer([playerTest1, playerTest2, playerTest3]);

      expect(game.players.length, 3);
      expect(game.players[0].userName, "PlayerTest1");
      expect(game.players[1].userName, "PlayerTest2");
      expect(game.players[2].userName, "PlayerTest3");

      expect(game.players[0].getDeckLength(), 20);
      expect(game.players[1].getDeckLength(), 20);
      expect(game.players[2].getDeckLength(), 20);

      expect(game.battleField.getLength(), 1);

      expect(game.isSetup, true);
    });
    test("Game is created and setup / card is correct deal (4 players)", () {
      Game game = setUpWithNbPlayer(
          [playerTest1, playerTest2, playerTest3, playerTest4]);

      expect(game.players.length, 4);
      expect(game.players[0].userName, "PlayerTest1");
      expect(game.players[1].userName, "PlayerTest2");
      expect(game.players[2].userName, "PlayerTest3");
      expect(game.players[3].userName, "PlayerTest4");

      expect(game.players[0].getDeckLength(), 15);
      expect(game.players[1].getDeckLength(), 15);
      expect(game.players[2].getDeckLength(), 15);
      expect(game.players[2].getDeckLength(), 15);

      expect(game.battleField.getLength(), 1);

      expect(game.isSetup, true);
    });
    test("Game is created and setup / card is correct deal (5 players)", () {
      Game game = setUpWithNbPlayer(
          [playerTest1, playerTest2, playerTest3, playerTest4, playerTest5]);

      expect(game.players.length, 5);
      expect(game.players[0].userName, "PlayerTest1");
      expect(game.players[1].userName, "PlayerTest2");
      expect(game.players[2].userName, "PlayerTest3");
      expect(game.players[3].userName, "PlayerTest4");
      expect(game.players[4].userName, "PlayerTest5");

      expect(game.players[0].getDeckLength(), 12);
      expect(game.players[1].getDeckLength(), 12);
      expect(game.players[2].getDeckLength(), 12);
      expect(game.players[3].getDeckLength(), 12);
      expect(game.players[4].getDeckLength(), 12);

      expect(game.battleField.getLength(), 1);

      expect(game.isSetup, true);
    });
    test("Game is created and setup / card is correct deal (6 players)", () {
      Game game = setUpWithNbPlayer([
        playerTest1,
        playerTest2,
        playerTest3,
        playerTest4,
        playerTest5,
        playerTest6
      ]);

      expect(game.players.length, 6);
      expect(game.players[0].userName, "PlayerTest1");
      expect(game.players[1].userName, "PlayerTest2");
      expect(game.players[2].userName, "PlayerTest3");
      expect(game.players[3].userName, "PlayerTest4");
      expect(game.players[4].userName, "PlayerTest5");
      expect(game.players[5].userName, "PlayerTest6");

      expect(game.players[0].getDeckLength(), 10);
      expect(game.players[1].getDeckLength(), 10);
      expect(game.players[2].getDeckLength(), 10);
      expect(game.players[3].getDeckLength(), 10);
      expect(game.players[4].getDeckLength(), 10);
      expect(game.players[5].getDeckLength(), 10);

      expect(game.battleField.getLength(), 1);

      expect(game.isSetup, true);
    });

    test("Game is not setup with less than 3 players", () {
      expect(
            () => setUpWithNbPlayer([playerTest1, playerTest2]),
        throwsA(
          predicate(
                (e) =>
            e is Exception &&
                e.toString().contains('Invalid number of players (3-6), Actual: 2'),
          ),
        ),
      );
    });
    test("Game is not setup with more than 6 players", () {
      expect(
            () => setUpWithNbPlayer([
              playerTest1,
              playerTest2,
              playerTest3,
              playerTest4,
              playerTest5,
              playerTest6,
              playerTest6,
              playerTest6
            ]),
        throwsA(
          predicate(
                (e) =>
            e is Exception &&
                e.toString().contains('Invalid number of players (3-6), Actual: 8'),
          ),
        ),
      );
    });

    test("Game with deck size not divisible by number of players + 1", () {
      // Create a game with 3 players
      Game game = Game([playerTest1, playerTest2, playerTest3]);
      game.playOrder = true;
      game.battleMode = false;
      game.isInPause = false;
      game.isGameOver = false;
      game.nbCardGame = 28;
      game.currentPlayerTurn = 0;
      game.battleField = BattleField();
      game.cardFactory = CardFactory(game);

      // Create a deck for 3 players with an invalid size (27 cards)
      List<GameCard> deck = game.cardFactory.createDeck(2, 3, 5, 5);

      expect(
            () => game.dealCards(deck),
        throwsA(
          predicate(
                (e) =>
            e is Exception &&
                e.toString().contains('Deck size is not valid. It must be divisible by the number of players plus one for the battle field card'),
          ),
        ),
      );
    });
    test("Game with empty deck", () {
      // Create a game with 3 players
      Game game = Game([playerTest1, playerTest2, playerTest3]);
      game.playOrder = true;
      game.battleMode = false;
      game.isInPause = false;
      game.isGameOver = false;
      game.nbCardGame = 28;
      game.currentPlayerTurn = 0;
      game.battleField = BattleField();
      game.cardFactory = CardFactory(game);

      // Create an empty deck
      List<GameCard> deck = [];
      expect(
            () => game.dealCards(deck),
        throwsA(
          predicate(
                (e) =>
            e is Exception &&
                e.toString().contains('Deck is empty'),
          ),
        ),
      );
    });
    test("Game with card not equally distributed", () {
      // Add one card to one player to make the distribution unequal
      playerTest1.deck.add(CommanderCard());

      // Create a game with 3 players
      Game game = Game([playerTest1, playerTest2, playerTest3]);
      game.playOrder = true;
      game.battleMode = false;
      game.isInPause = false;
      game.isGameOver = false;
      game.nbCardGame = 28;
      game.currentPlayerTurn = 0;
      game.battleField = BattleField();
      game.cardFactory = CardFactory(game);

      // Create a deck for 3 players
      List<GameCard> deck = game.cardFactory.createDeck(3, 3, 5, 5);

      expect(
            () => game.dealCards(deck),
        throwsA(
          predicate(
                (e) =>
            e is Exception &&
                e.toString().contains('Cards are not equally distributed among players'),
          ),
        ),
      );
    });
    test("Army Group Dont Have Good Size ", () {
      CardFactory factory = CardFactory(canPlayedCardGame);

      expect(
            () => factory.createRecruitmentCards(2, 7, 0, 0),
        throwsA(
          predicate(
                (e) =>
            e is Exception &&
                e.toString().contains('Army card count must be a multiple of 3'),
          ),
        ),
      );
    });
    test("Mage Group Dont Have Good Size ", () {
      CardFactory factory = CardFactory(canPlayedCardGame);

      expect(
            () => factory.createRecruitmentCards(2, 6, 9, 0),
        throwsA(
          predicate(
                (e) =>
            e is Exception &&
                e.toString().contains('Mage card count must be a multiple of 5'),
          ),
        ),
      );
    });
  });

  group("Game play tests", () {
    test("Game play order is correct", () {
      // Play order : clockwise
      Game game = Game([playerTest1, playerTest2, playerTest3]);
      game.setUpGame(0);

      expect(game.playOrder, true);
      expect(game.currentPlayerTurn, 0);
      expect(game.getPreviousPlayerTurnIndex(), 2);
      expect(game.getNextPlayerTurnIndex(), 1);

      // Simulate a turn change
      game.nextTurn();

      expect(game.playOrder, true);
      expect(game.currentPlayerTurn, 1);
      expect(game.getPreviousPlayerTurnIndex(), 0);
      expect(game.getNextPlayerTurnIndex(), 2);

      // Play order : counterclockwise
      game.playOrder = false;

      // Simulate a turn change
      game.nextTurn();

      expect(game.playOrder, false);
      expect(game.currentPlayerTurn, 0);
      expect(game.getPreviousPlayerTurnIndex(), 1);
      expect(game.getNextPlayerTurnIndex(), 2);
    });
    test("Play game successfully", () {
      // All players card are dealt
      testPlayer1.deck.addAll([FakeCard(), FakeCard()]);
      testPlayer2.deck.addAll([FakeCard(), FakeCard(), FakeCard(), FakeCard()]);
      testPlayer3.deck
          .addAll([FakeCard(), FakeCard(), FakeCard(), FakeCard(), FakeCard()]);

      // Create a game with 3 players
      Game game = Game([testPlayer1, testPlayer2, testPlayer3]);
      game.playOrder = true;
      game.battleMode = false;
      game.isInPause = false;
      game.isGameOver = false;
      game.nbCardGame = 28;
      game.currentPlayerTurn = 0;
      game.battleField = BattleField();
      game.cardFactory = CardFactory(game);

      // Set up the game (Player 1 starts)
      game.startGame(0);

      // Game is over
      expect(game.isGameOver, isTrue);

      // Player 1 and 2 are not alive
      expect(testPlayer1.status == PlayerStatusConstant.alive, isFalse);
      expect(testPlayer2.status == PlayerStatusConstant.alive, isFalse);

      // Player 3 is alive
      expect(testPlayer3.status == PlayerStatusConstant.alive, isTrue);
    });
    test("Player in pause and time out", () {
      // All players card are dealt
      testPlayer1.deck.addAll([FakeCard(), FakeCard()]);
      testPlayer2.deck.addAll([FakeCard(), FakeCard(), FakeCard(), FakeCard()]);
      testPlayer3.deck
          .addAll([FakeCard(), FakeCard(), FakeCard(), FakeCard(), FakeCard()]);

      // Player 2 is in pause
      testPlayer2.pausePlayer();

      // Create a game with 3 players
      Game game = Game([testPlayer1, testPlayer2, testPlayer3]);
      game.playOrder = true;
      game.battleMode = false;
      game.isInPause = false;
      game.isGameOver = false;
      game.nbCardGame = 28;
      game.currentPlayerTurn = 0;
      game.battleField = BattleField();
      game.cardFactory = CardFactory(game);

      // Set up the game (Player 1 starts)
      game.startGame(0);

      // Game is over
      expect(game.isGameOver, isTrue);

      // Player 1 and 2 are not alive
      expect(testPlayer1.status == PlayerStatusConstant.alive, isFalse);
      expect(testPlayer2.status == PlayerStatusConstant.alive, isFalse);

      // Player 3 is alive
      expect(testPlayer3.status == PlayerStatusConstant.alive, isTrue);
    });
  });

  group("Win conditions tests", () {
    test("One player win", () {
      // All players card are dealt
      testPlayer1.deck.addAll([FakeCard(), FakeCard()]);
      testPlayer2.deck.addAll([FakeCard(), FakeCard(), FakeCard(), ConquestKnightCard()]);
      testPlayer3.deck
          .addAll([FakeCard(), FakeCard(), FakeCard(), FakeCard(), FakeCard()]);

      // Create a game with 3 players
      Game game = Game([testPlayer1, testPlayer2, testPlayer3]);
      game.playOrder = true;
      game.battleMode = false;
      game.isInPause = false;
      game.isGameOver = false;
      game.nbCardGame = 28;
      game.currentPlayerTurn = 0;
      game.battleField = BattleField();
      game.cardFactory = CardFactory(game);

      // Set up the game (Player 1 starts)
      game.startGame(0);

      // Game is over
      expect(game.isGameOver, isTrue);

      // Player 1 and 2 are not alive
      expect(testPlayer1.status == PlayerStatusConstant.alive, isFalse);
      expect(testPlayer2.status == PlayerStatusConstant.alive, isFalse);

      // Player 3 is alive
      expect(testPlayer3.status == PlayerStatusConstant.alive, isTrue);
      expect(game.winCondition, "Only one player is left alive");
    });
    test("Conquest win", () {
      // All players card are dealt
      testPlayer1.deck.addAll([ConquestKnightCard()]);
      testPlayer2.deck.addAll([FakeCard(), FakeCard(), FakeCard(), FakeCard()]);
      testPlayer3.deck
          .addAll([FakeCard(), FakeCard(), FakeCard(), FakeCard(), FakeCard()]);

      // Create a game with 3 players
      Game game = Game([testPlayer1, testPlayer2, testPlayer3]);
      game.playOrder = true;
      game.battleMode = false;
      game.isInPause = false;
      game.isGameOver = false;
      game.nbCardGame = 28;
      game.currentPlayerTurn = 0;
      game.battleField = BattleField();
      game.cardFactory = CardFactory(game);

      // Set up the game (Player 1 starts)
      game.startGame(0);

      // Game is over
      expect(game.isGameOver, isTrue);
      expect(game.winCondition, "Wins by conquest");
    });

    test("Tie", () {
      // All players card are dealt
      testPlayer1.deck.addAll([ArcherCard(), FakeCard()]);
      testPlayer2.deck.addAll([GuardCard()]);
      testPlayer3.deck
          .addAll([ConquestKnightCard(), FakeCard(), FakeCard()]);

      // Create a game with 3 players
      Game game = Game([testPlayer1, testPlayer2, testPlayer3]);
      game.playOrder = true;
      game.battleMode = false;
      game.isInPause = false;
      game.isGameOver = false;
      game.nbCardGame = 28;
      game.currentPlayerTurn = 0;
      game.battleField = BattleField();
      game.cardFactory = CardFactory(game);

      // Set up the game (Player 1 starts)
      game.startGame(0);

      // Game is over
      expect(game.isGameOver, isTrue);
      expect(game.winCondition, "Draw: 3 players eliminated after a chain of deaths");
    });
  });

  group("Can Play Card Tests", () {
    test("Check Can Play State", () {
      expect(canPlayedCardGame.players[0].deck.where((card) => !card.canPlay).length, 2);
      CardsVerifier.verifyPlayerNbCard(canPlayedCardGame.players[0], 3);

      int indexCard =
        CardsVerifier.getIndexCardByType(canPlayedCardGame.players[0], SwordsmanCard);

      canPlayedCardGame.players[0].playCard(canPlayedCardGame, indexCard);

      canPlayedCardGame.handleFamineKnight(canPlayedCardGame.players[0]);

      CardsVerifier.verifyPlayerNbCard(canPlayedCardGame.players[0], 2);
      expect(canPlayedCardGame.players[0].deck.where((card) => !card.canPlay).length, 0);
    });

    test("Check Can Play with Famine", () {
      expect(canPlayedCardGame.players[1].deck.where((card) => !card.canPlay).length, 1);
      CardsVerifier.verifyPlayerNbCard(canPlayedCardGame.players[1], 2);

      canPlayedCardGame.handleFamineKnight(canPlayedCardGame.players[1]);

      CardsVerifier.verifyPlayerNbCard(canPlayedCardGame.players[1], 1);
      expect(canPlayedCardGame.players[1].deck.where((card) => !card.canPlay).length, 0);
    });
  });
}
