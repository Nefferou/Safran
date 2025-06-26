import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/card_factory.dart';
import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/game.dart';
import 'package:safran/models/player.dart';

import '../utils/fake_card.dart';
import '../utils/fake_player.dart';

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
      try {
        Game game = setUpWithNbPlayer([playerTest1, playerTest2]);

        // Fail if the exception is not thrown
        fail("Exception was expected but not thrown.");
      } catch (e) {
        expect(e.toString(),
            "Exception: Invalid number of players (3-6), Actual: 2");
      }
    });
    test("Game is not setup with more than 6 players", () {
      try {
        Game game = setUpWithNbPlayer([
          playerTest1,
          playerTest2,
          playerTest3,
          playerTest4,
          playerTest5,
          playerTest6,
          playerTest6,
          playerTest6
        ]);

        // Fail if the exception is not thrown
        fail("Exception was expected but not thrown.");
      } catch (e) {
        expect(e.toString(),
            "Exception: Invalid number of players (3-6), Actual: 8");
      }
    });

    test("Game with deck size not divisible by number of players + 1", () {
      try {
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
        game.dealCards(deck);

        // Fail if the exception is not thrown
        fail("Exception was expected but not thrown.");
      } catch (e) {
        expect(e.toString(),
            "Exception: Deck size is not valid. It must be divisible by the number of players plus one for the battle field card");
      }
    });
    test("Game with empty deck", () {
      try {
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
        game.dealCards(deck);

        // Fail if the exception is not thrown
        fail("Exception was expected but not thrown.");
      } catch (e) {
        expect(e.toString(), "Exception: Deck is empty");
      }
    });
    test("Game with card not equally distributed", () {
      try {
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
        game.dealCards(deck);

        // Fail if the exception is not thrown
        fail("Exception was expected but not thrown.");
      } catch (e) {
        expect(e.toString(),
            "Exception: Cards are not equally distributed among players");
      }
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
      expect(testPlayer1.isAlive, isFalse);
      expect(testPlayer2.isAlive, isFalse);

      // Player 3 is alive
      expect(testPlayer3.isAlive, isTrue);
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
      expect(testPlayer1.isAlive, isFalse);
      expect(testPlayer2.isAlive, isFalse);

      // Player 3 is alive
      expect(testPlayer3.isAlive, isTrue);
    });
  });
}
