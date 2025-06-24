import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/card/recruitment/mage/aeromancerCard.dart';
import 'package:safran/models/card/recruitment/mage/arcanistCard.dart';
import 'package:safran/models/card/recruitment/mage/geomancerCard.dart';
import 'package:safran/models/card/recruitment/thiefCard.dart';
import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';
import 'package:safran/models/card/triad/fateHerald/diseaseHeraldCard.dart';
import 'package:safran/models/card/triad/saintProtector/healingSaintCard.dart';
import 'package:safran/models/game.dart';

import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
  });

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
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], CommanderCard);

        int indexCardCommander =
            CardsVerifier.getIndexCardByType(customGame.players[0], CommanderCard);

        Queue<GameCard> battleFieldBeforeShuffle =
            customGame.getBattleField().cards;
        customGame.getCurrentPlayer().playCard(customGame, indexCardCommander);
        Queue<GameCard> battleFieldAfterShuffle =
            customGame.getBattleField().cards;

        expect(
            battleFieldBeforeShuffle, isNot(equals(battleFieldAfterShuffle)));

        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
        CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 5);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
      });
/*
      group("Cards Army", () {
        test("Card Guard (Counter OK)", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], SpearmanCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], GuardCard);

          int indexCardSpearman =
              CardsVerifier.getIndexCardByType(customGame.players[0], SpearmanCard);
          int indexCard2 = CardsVerifier.getIndexCardByType(customGame.players[1], GuardCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCardSpearman);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 7);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], SpearmanCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], GuardCard);
        });

        test("Card Guard (Counter KO)", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], SwordsmanCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], GuardCard);

          int indexCard1 =
              CardsVerifier.getIndexCardByType(customGame.players[0], SwordsmanCard);
          int indexCard2 = CardsVerifier.getIndexCardByType(customGame.players[1], GuardCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 6);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], SwordsmanCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], GuardCard);
        });

        test("Card Spearman (Counter OK)", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], SwordsmanCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], SpearmanCard);

          int indexCard1 =
              CardsVerifier.getIndexCardByType(customGame.players[0], SwordsmanCard);
          int indexCard2 =
              CardsVerifier.getIndexCardByType(customGame.players[1], SpearmanCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 7);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], SwordsmanCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], SpearmanCard);
        });

        test("Card Spearman (Counter KO)", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], SpearmanCard);

          int indexCard1 = CardsVerifier.getIndexCardByType(customGame.players[0], GuardCard);
          int indexCard2 =
              CardsVerifier.getIndexCardByType(customGame.players[1], SpearmanCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 6);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], SpearmanCard);
        });

        test("Card Swordsman (Counter OK)", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], SwordsmanCard);

          int indexCard1 = CardsVerifier.getIndexCardByType(customGame.players[0], GuardCard);
          int indexCard2 =
              CardsVerifier.getIndexCardByType(customGame.players[1], SwordsmanCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 7);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], SwordsmanCard);
        });

        test("Card Swordsman (Counter KO)", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], SpearmanCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], SwordsmanCard);

          int indexCard1 =
              CardsVerifier.getIndexCardByType(customGame.players[0], SpearmanCard);
          int indexCard2 =
              CardsVerifier.getIndexCardByType(customGame.players[1], SwordsmanCard);

          expect(customGame.battleMode, false);

          customGame.players[0].playCard(customGame, indexCard1);
          expect(customGame.battleMode, true);

          customGame.nextTurn();

          customGame.players[1].playCard(customGame, indexCard2);
          expect(customGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 6);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], SpearmanCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], SwordsmanCard);
        });
      });
*/
      group("Cards Mage", () {
        test("Card Geomancer", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], GeomancerCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], GeomancerCard);

          int indexForGeomancerCard1 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), GeomancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForGeomancerCard1, 0);
          CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);

          customGame.nextTurn();

          int indexForGeomancerCard2 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), GeomancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForGeomancerCard2, 0);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 12);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], GeomancerCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], GeomancerCard);
        });

        test("Card Aeromancer", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], AeromancerCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], AeromancerCard);

          int indexForAeromancerCard1 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), AeromancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForAeromancerCard1, 0);
          CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);

          customGame.nextTurn();

          int indexForAeromancerCard2 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), AeromancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForAeromancerCard2, 0);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 12);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], AeromancerCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], AeromancerCard);
        });

        test("Card Arcanist", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], ArcanistCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], ArcanistCard);

          int indexForArcanistCard1 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), ArcanistCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForArcanistCard1, 0);
          CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 12);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 3);

          customGame.nextTurn();

          int indexForArcanistCard2 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), ArcanistCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForArcanistCard2, 0);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 14);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 2);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], ArcanistCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], ArcanistCard);
        });
      });

      test("Card Thielf", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], ThiefCard);

        int indexCard1 = CardsVerifier.getIndexCardByType(customGame.players[0], ThiefCard);

        customGame
            .getCurrentPlayer()
            .playCardWithTwoTargets(customGame, indexCard1, 0, 1);

        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
        CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 5);
      });
    });

    group("Card Triad", () {

      test("Card Fate Herald", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], DiseaseHeraldCard);

        int indexCardDiseaseHerald =
          CardsVerifier.getIndexCardByType(customGame.players[0], DiseaseHeraldCard);

        customGame
            .getCurrentPlayer()
            .playCardWithOneTarget(customGame, indexCardDiseaseHerald, 1);

        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
        CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 5);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], DiseaseHeraldCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], PlagueKnightCard);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], PlagueKnightCard);
      });

      test("Card Saint Protector", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], HealingSaintCard);

        int indexCardHealingSaint =
        CardsVerifier.getIndexCardByType(customGame.players[0], HealingSaintCard);

        customGame
            .getCurrentPlayer()
            .playCardWithoutTarget(customGame, indexCardHealingSaint);

        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
        CardsVerifier.verifyBattleFieldNbCard(customGame.getBattleField(), 6);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], HealingSaintCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], PlagueKnightCard);
      });

      /// TODO Test for four Knight
    });
  });
}
