import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/recruitment/army/guardCard.dart';
import 'package:safran/models/card/recruitment/army/spearmanCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/card/recruitment/mage/aeromancerCard.dart';
import 'package:safran/models/card/recruitment/mage/arcanistCard.dart';
import 'package:safran/models/card/recruitment/mage/geomancerCard.dart';
import 'package:safran/models/card/recruitment/thielfCard.dart';
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

  late Player playerWithConquestKnight;
  late Player playerWithFamineKnight;
  late Player playerWithPlagueKnight;
  late Player playerWithWarKnight;

  // Set up a custom game with specific players and cards
  setUpCustomGame() {
    Game customGame = Game([
      playerWithConquestKnight,
      playerWithFamineKnight,
      playerWithPlagueKnight,
      playerWithWarKnight
    ]);

    customGame.battleField = BattleField();

    customGame.players[0].deck.addAll([
      CommanderCard(),
      GuardCard(),
      SpearmanCard(),
      SwordsmanCard(),
      GeomancerCard(),
      AeromancerCard(),
      ArcanistCard(),
      ThielfCard(),
      DiseaseHeraldCard(),
      HealingSaintCard(),
      PlagueKnightCard()
    ]);
    customGame.players[1].deck.addAll([
      CommanderCard(),
      GuardCard(),
      SpearmanCard(),
      SwordsmanCard(),
      GeomancerCard(),
      AeromancerCard(),
      ArcanistCard(),
      ThielfCard(),
      SufferingHeraldCard(),
      AbundanceSaintCard(),
      FamineKnightCard()
    ]);
    customGame.players[2].deck.addAll([
      CommanderCard(),
      GuardCard(),
      SpearmanCard(),
      SwordsmanCard(),
      GeomancerCard(),
      AeromancerCard(),
      ArcanistCard(),
      ThielfCard(),
      PowerHeraldCard(),
      ProsperitySaintCard(),
      DiseaseHeraldCard()
    ]);
    customGame.players[3].deck.addAll([
      CommanderCard(),
      GuardCard(),
      SpearmanCard(),
      SwordsmanCard(),
      GeomancerCard(),
      AeromancerCard(),
      ArcanistCard(),
      ThielfCard(),
      ChaosHeraldCard(),
      PeaceSaintCard(),
      WarKnightCard()
    ]);
    customGame.getBattleField().cards.addAll(
        [CommanderCard(), GuardCard(), SpearmanCard(), SwordsmanCard()]);

    customGame.playOrder = true;
    customGame.battleMode = false;
    customGame.isSetup = true;
    customGame.isInPause = false;
    customGame.isGameOver = false;
    customGame.currentPlayerTurn = 0;
    customGame.testingMode = true;

    return customGame;
  }

  setUp(() {
    playerWithConquestKnight = Player("PlayerWithConquestKnight");
    playerWithFamineKnight = Player("PlayerWithFamineKnight");
    playerWithPlagueKnight = Player("PlayerWithPlagueKnight");
    playerWithWarKnight = Player("PlayerWithWarKnight");

    customGame = setUpCustomGame();
  });

  getIndexCardByType(Player player, Type cardType) {
    int indexCard =
        player.deck.indexWhere((card) => card.runtimeType == cardType);
    return indexCard;
  }

  verifyPlayerNbCard(Player player, int playerNbCard) {
    // Verify the number of cards in the player's deck
    expect(player.getDeckLength(), playerNbCard);
  }

  verifyBattleFieldNbCard(BattleField battleField, int battleFieldNbCard) {
    // Verify the number of cards in the battlefield
    expect(battleField.getLength(), battleFieldNbCard);
  }

  verifyIfCardTypeIsInDeck(Player player, Type cardType) {
    // Verify if the card type is in the player's deck
    expect(getIndexCardByType(player, cardType), isNot(-1));
  }

  verifyIfCardTypeIsntInDeck(Player player, Type cardType) {
    // Verify if the card type is in the player's deck
    expect(getIndexCardByType(player, cardType), -1);
  }

  group("Game custom tests", () {
    test("Game custom is created and card is deal (manually)", () {
      expect(customGame.players[0].getDeckLength(), 11);
      expect(customGame.players[1].getDeckLength(), 11);
      expect(customGame.players[2].getDeckLength(), 11);
      expect(customGame.players[3].getDeckLength(), 11);

      expect(customGame.getBattleField().getLength(), 4);

      expect(customGame.isSetup, true);
    });
  });

  group("Cards tests", () {
    group("Card Recruitment", () {
      test("Card Commander", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyBattleFieldNbCard(customGame.getBattleField(), 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], CommanderCard);

        int indexCardCommander =
            getIndexCardByType(customGame.players[0], CommanderCard);

        Queue<GameCard> battleFieldBeforeShuffle =
            customGame.getBattleField().cards;
        customGame.getCurrentPlayer().playCard(customGame, indexCardCommander);
        Queue<GameCard> battleFieldAfterShuffle =
            customGame.getBattleField().cards;

        expect(
            battleFieldBeforeShuffle, isNot(equals(battleFieldAfterShuffle)));

        verifyPlayerNbCard(customGame.players[0], 10);
        verifyBattleFieldNbCard(customGame.getBattleField(), 5);
        verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
      });

      group("Cards Army", () {
        test("Card Guard (Counter OK)", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], SpearmanCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], GuardCard);

          int indexCardSpearman =
              getIndexCardByType(customGame.players[0], SpearmanCard);
          int indexCard2 = getIndexCardByType(customGame.players[1], GuardCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCardSpearman);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          verifyPlayerNbCard(customGame.players[0], 9);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 7);
          verifyIfCardTypeIsntInDeck(customGame.players[0], SpearmanCard);
          verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], GuardCard);
        });

        test("Card Guard (Counter KO)", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], SwordsmanCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], GuardCard);

          int indexCard1 =
              getIndexCardByType(customGame.players[0], SwordsmanCard);
          int indexCard2 = getIndexCardByType(customGame.players[1], GuardCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          verifyPlayerNbCard(customGame.players[0], 10);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 6);
          verifyIfCardTypeIsntInDeck(customGame.players[0], SwordsmanCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], GuardCard);
        });

        test("Card Spearman (Counter OK)", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], SwordsmanCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], SpearmanCard);

          int indexCard1 =
              getIndexCardByType(customGame.players[0], SwordsmanCard);
          int indexCard2 =
              getIndexCardByType(customGame.players[1], SpearmanCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          verifyPlayerNbCard(customGame.players[0], 9);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 7);
          verifyIfCardTypeIsntInDeck(customGame.players[0], SwordsmanCard);
          verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], SpearmanCard);
        });

        test("Card Spearman (Counter KO)", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], SpearmanCard);

          int indexCard1 = getIndexCardByType(customGame.players[0], GuardCard);
          int indexCard2 =
              getIndexCardByType(customGame.players[1], SpearmanCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          verifyPlayerNbCard(customGame.players[0], 10);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 6);
          verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], SpearmanCard);
        });

        test("Card Swordsman (Counter OK)", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], SwordsmanCard);

          int indexCard1 = getIndexCardByType(customGame.players[0], GuardCard);
          int indexCard2 =
              getIndexCardByType(customGame.players[1], SwordsmanCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          verifyPlayerNbCard(customGame.players[0], 9);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 7);
          verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
          verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], SwordsmanCard);
        });

        test("Card Swordsman (Counter KO)", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], SpearmanCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], SwordsmanCard);

          int indexCard1 =
              getIndexCardByType(customGame.players[0], SpearmanCard);
          int indexCard2 =
              getIndexCardByType(customGame.players[1], SwordsmanCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          verifyPlayerNbCard(customGame.players[0], 10);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 6);
          verifyIfCardTypeIsntInDeck(customGame.players[0], SpearmanCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], SwordsmanCard);
        });
      });

      group("Cards Mage", () {
        test("Card Geomancer", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], GeomancerCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], GeomancerCard);

          int indexForGeomancerCard1 =
              getIndexCardByType(customGame.getCurrentPlayer(), GeomancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForGeomancerCard1, 0);
          verifyPlayerNbCard(customGame.getCurrentPlayer(), 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);

          customGame.nextTurn();

          int indexForGeomancerCard2 =
              getIndexCardByType(customGame.getCurrentPlayer(), GeomancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForGeomancerCard2, 0);

          verifyPlayerNbCard(customGame.players[0], 12);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsntInDeck(customGame.players[0], GeomancerCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], GeomancerCard);
        });

        test("Card Aeromancer", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], AeromancerCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], AeromancerCard);

          int indexForAeromancerCard1 =
              getIndexCardByType(customGame.getCurrentPlayer(), AeromancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForAeromancerCard1, 0);
          verifyPlayerNbCard(customGame.getCurrentPlayer(), 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);

          customGame.nextTurn();

          int indexForAeromancerCard2 =
              getIndexCardByType(customGame.getCurrentPlayer(), AeromancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForAeromancerCard2, 0);

          verifyPlayerNbCard(customGame.players[0], 12);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], AeromancerCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], AeromancerCard);
        });

        test("Card Arcanist", () {
          verifyPlayerNbCard(customGame.players[0], 11);
          verifyPlayerNbCard(customGame.players[1], 11);
          verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          verifyIfCardTypeIsInDeck(customGame.players[0], ArcanistCard);
          verifyIfCardTypeIsInDeck(customGame.players[1], ArcanistCard);

          int indexForArcanistCard1 =
              getIndexCardByType(customGame.getCurrentPlayer(), ArcanistCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForArcanistCard1, 0);
          verifyPlayerNbCard(customGame.getCurrentPlayer(), 12);
          verifyBattleFieldNbCard(customGame.getBattleField(), 3);

          customGame.nextTurn();

          int indexForArcanistCard2 =
              getIndexCardByType(customGame.getCurrentPlayer(), ArcanistCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForArcanistCard2, 0);

          verifyPlayerNbCard(customGame.players[0], 14);
          verifyPlayerNbCard(customGame.players[1], 10);
          verifyBattleFieldNbCard(customGame.getBattleField(), 2);
          verifyIfCardTypeIsInDeck(customGame.players[0], ArcanistCard);
          verifyIfCardTypeIsntInDeck(customGame.players[1], ArcanistCard);
        });
      });

      test("Card Thielf", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.getBattleField(), 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], ThielfCard);

        int indexCard1 = getIndexCardByType(customGame.players[0], ThielfCard);

        customGame
            .getCurrentPlayer()
            .playCardWithTwoTargets(customGame, indexCard1, 0, 1);

        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.getBattleField(), 5);
      });
    });

    group("Card Triad", () {
      test("Card Fate Herald", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.getBattleField(), 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], DiseaseHeraldCard);

        int indexCardDiseaseHerald =
            getIndexCardByType(customGame.players[0], DiseaseHeraldCard);

        customGame
            .getCurrentPlayer()
            .playCardWithOneTarget(customGame, indexCardDiseaseHerald, 1);

        verifyPlayerNbCard(customGame.players[0], 9);
        verifyPlayerNbCard(customGame.players[1], 12);
        verifyBattleFieldNbCard(customGame.getBattleField(), 5);
        verifyIfCardTypeIsntInDeck(customGame.players[0], DiseaseHeraldCard);
        verifyIfCardTypeIsntInDeck(customGame.players[0], PlagueKnightCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], PlagueKnightCard);
      });

      test("Card Saint Protector", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyBattleFieldNbCard(customGame.getBattleField(), 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], HealingSaintCard);

        int indexCardHealingSaint =
        getIndexCardByType(customGame.players[0], HealingSaintCard);

        customGame
            .getCurrentPlayer()
            .playCardWithoutTarget(customGame, indexCardHealingSaint);

        verifyPlayerNbCard(customGame.players[0], 9);
        verifyBattleFieldNbCard(customGame.getBattleField(), 6);
        verifyIfCardTypeIsntInDeck(customGame.players[0], HealingSaintCard);
        verifyIfCardTypeIsntInDeck(customGame.players[0], PlagueKnightCard);
      });

      /// TODO Test for four Knight
    });
  });
}
