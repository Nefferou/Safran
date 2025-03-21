import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/recruitment/army/gardCard.dart';
import 'package:safran/models/card/recruitment/army/spearmanCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/card/recruitment/mage/aeromancerCard.dart';
import 'package:safran/models/card/recruitment/mage/arcanistCard.dart';
import 'package:safran/models/card/recruitment/mage/geomancerCard.dart';
import 'package:safran/models/card/recruitment/thielfCard.dart';
import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/famineKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/warKnightCard.dart';
import 'package:safran/models/card/triad/fateHerald/chaosHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/diseaseHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/powerHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/sufferingHeraldCard.dart';
import 'package:safran/models/card/triad/saintProtector/abundanceSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/healingSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/peaceSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/prosperitySaintCard.dart';
import 'package:safran/models/game.dart';
import 'package:safran/models/player.dart';

void main() {
  late Game customGame;

  late Player playerTest1;
  late Player playerTest2;
  late Player playerTest3;
  late Player playerTest4;
  late Player playerTest5;
  late Player playerTest6;

  late Player playerWithConquestKnight;
  late Player playerWithFamineKnight;
  late Player playerWithPlagueKnight;
  late Player playerWithWarKnight;

  setUp(() {
    playerTest1 = Player("PlayerTest1");
    playerTest2 = Player("PlayerTest2");
    playerTest3 = Player("PlayerTest3");
    playerTest4 = Player("PlayerTest4");
    playerTest5 = Player("PlayerTest5");
    playerTest6 = Player("PlayerTest6");

    playerWithConquestKnight = Player("PlayerWithConquestKnight");
    playerWithFamineKnight = Player("PlayerWithFamineKnight");
    playerWithPlagueKnight = Player("PlayerWithPlagueKnight");
    playerWithWarKnight = Player("PlayerWithWarKnight");
  });

  setUpWithNbPlayer(List<Player> players) {
    Game game = new Game(players);
    game.setUpGame();

    return game;
  }

  setUpCustomGame() {
    Game customGame = Game([
      playerWithConquestKnight,
      playerWithFamineKnight,
      playerWithPlagueKnight,
      playerWithWarKnight
    ]);
    customGame.battleField = BattleField();

    customGame.players[0].deck.addAll([
      CommanderCard(customGame),
      GardCard(customGame),
      SpearmanCard(customGame),
      SwordsmanCard(customGame),
      GeomancerCard(customGame),
      AeromancerCard(customGame),
      ArcanistCard(customGame),
      ThielfCard(customGame),
      PowerHeraldCard(customGame),
      ProsperitySaintCard(customGame),
      ConquestKnightCard(customGame)
    ]);
    customGame.players[1].deck.addAll([
      CommanderCard(customGame),
      GardCard(customGame),
      SpearmanCard(customGame),
      SwordsmanCard(customGame),
      GeomancerCard(customGame),
      AeromancerCard(customGame),
      ArcanistCard(customGame),
      ThielfCard(customGame),
      SufferingHeraldCard(customGame),
      AbundanceSaintCard(customGame),
      FamineKnightCard(customGame)
    ]);
    customGame.players[2].deck.addAll([
      CommanderCard(customGame),
      GardCard(customGame),
      SpearmanCard(customGame),
      SwordsmanCard(customGame),
      GeomancerCard(customGame),
      AeromancerCard(customGame),
      ArcanistCard(customGame),
      ThielfCard(customGame),
      PowerHeraldCard(customGame),
      DiseaseHeraldCard(customGame),
      PlagueKnightCard(customGame)
    ]);
    customGame.players[3].deck.addAll([
      CommanderCard(customGame),
      GardCard(customGame),
      SpearmanCard(customGame),
      SwordsmanCard(customGame),
      GeomancerCard(customGame),
      AeromancerCard(customGame),
      ArcanistCard(customGame),
      ThielfCard(customGame),
      ChaosHeraldCard(customGame),
      PeaceSaintCard(customGame),
      WarKnightCard(customGame)
    ]);
    customGame.battleField.cards.add(CommanderCard(customGame));

    customGame.playOrder = true;
    customGame.battleMode = false;
    customGame.isSetup = true;

    return customGame;
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
      } catch (e) {
        expect(e.toString(),
            "Exception: Invalid number of players (3-6), Actual: 8");
      }
    });
  });

  group("Game custom tests", () {
    test("Game custom is created and card is deal (manually)", () {
      Game customGame = setUpCustomGame();

      expect(customGame.players[0].getDeckLength(), 11);
      expect(customGame.players[1].getDeckLength(), 11);
      expect(customGame.players[2].getDeckLength(), 11);
      expect(customGame.players[3].getDeckLength(), 11);

      expect(customGame.battleField.getLength(), 1);

      expect(customGame.isSetup, true);
    });
  });
}
