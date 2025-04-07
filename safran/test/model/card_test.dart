import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/card.dart';
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
  late Player playerWithConquestKnight;
  late Player playerWithFamineKnight;
  late Player playerWithPlagueKnight;
  late Player playerWithWarKnight;

  setUp(() {

    playerWithConquestKnight = Player("PlayerWithConquestKnight");
    playerWithFamineKnight = Player("PlayerWithFamineKnight");
    playerWithPlagueKnight = Player("PlayerWithPlagueKnight");
    playerWithWarKnight = Player("PlayerWithWarKnight");
  });

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
      DiseaseHeraldCard(customGame),
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
      HealingSaintCard(customGame),
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
    customGame.battleField.cards.addAll([
      GardCard(customGame),
      SpearmanCard(customGame),
      SwordsmanCard(customGame),
      GardCard(customGame),
      SpearmanCard(customGame),
      SwordsmanCard(customGame),
      GeomancerCard(customGame),
      AeromancerCard(customGame),
      ArcanistCard(customGame),
    ]);

    customGame.playOrder = true;
    customGame.battleMode = false;
    customGame.isSetup = true;

    return customGame;
  }

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

    test("Card Commander", () {
      Game customGame = setUpCustomGame();

      expect(customGame.players[0].getDeckLength(), 11);

      Queue<Card> battleFieldBeforeShuffle = customGame.battleField.cards;
      customGame.players[0].deck[0];
      Queue<Card> battleFieldAfterShuffle = customGame.battleField.cards;

      expect(customGame.players[0].getDeckLength(), 10);
      expect(battleFieldBeforeShuffle, isNot(battleFieldAfterShuffle));

      expect(playerWithConquestKnight.deck[0].name, "Commander");
    });
  });
}