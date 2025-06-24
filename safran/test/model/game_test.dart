import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/game.dart';
import 'package:safran/models/player.dart';

void main() {
  late Player playerTest1;
  late Player playerTest2;
  late Player playerTest3;
  late Player playerTest4;
  late Player playerTest5;
  late Player playerTest6;

  setUp(() {
    playerTest1 = Player("PlayerTest1");
    playerTest2 = Player("PlayerTest2");
    playerTest3 = Player("PlayerTest3");
    playerTest4 = Player("PlayerTest4");
    playerTest5 = Player("PlayerTest5");
    playerTest6 = Player("PlayerTest6");
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
      expect(game.players[0].getName(), "PlayerTest1");
      expect(game.players[1].getName(), "PlayerTest2");
      expect(game.players[2].getName(), "PlayerTest3");

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
      expect(game.players[0].getName(), "PlayerTest1");
      expect(game.players[1].getName(), "PlayerTest2");
      expect(game.players[2].getName(), "PlayerTest3");
      expect(game.players[3].getName(), "PlayerTest4");

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
      expect(game.players[0].getName(), "PlayerTest1");
      expect(game.players[1].getName(), "PlayerTest2");
      expect(game.players[2].getName(), "PlayerTest3");
      expect(game.players[3].getName(), "PlayerTest4");
      expect(game.players[4].getName(), "PlayerTest5");

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
      expect(game.players[0].getName(), "PlayerTest1");
      expect(game.players[1].getName(), "PlayerTest2");
      expect(game.players[2].getName(), "PlayerTest3");
      expect(game.players[3].getName(), "PlayerTest4");
      expect(game.players[4].getName(), "PlayerTest5");
      expect(game.players[5].getName(), "PlayerTest6");

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
        Game game = setUpWithNbPlayer([playerTest1, playerTest2, playerTest3]);

        // Create a deck for 3 players with an invalid size (27 cards)
        List<GameCard> deck = game.cardFactory.createDeck(2, 3, 5, 5);
        game.dealCards(deck);

        // Fail if the exception is not thrown
        fail("Exception was expected but not thrown.");
      } catch (e) {
        expect(e.toString(),
            "Exception: Deck size must be divisible by the number of players plus one for the battle field card.");
      }
    });

    test("Game with empty deck", () {
      try {
        Game game = setUpWithNbPlayer([playerTest1, playerTest2, playerTest3]);

        // Create an empty deck
        List<GameCard> deck = [];
        game.dealCards(deck);

        // Fail if the exception is not thrown
        fail("Exception was expected but not thrown.");
      } catch (e) {
        expect(e.toString(), "Exception: Deck is empty");
      }
    });
  });
}
