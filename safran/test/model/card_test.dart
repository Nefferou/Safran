import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/recruitment/army/archerCard.dart';
import 'package:safran/models/card/recruitment/army/guardCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/card/recruitment/mage/aeromancerCard.dart';
import 'package:safran/models/card/recruitment/mage/arcanistCard.dart';
import 'package:safran/models/card/recruitment/mage/geomancerCard.dart';
import 'package:safran/models/card/recruitment/thiefCard.dart';
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

import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;
  late Game knightGame;
  late Game armyGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
    knightGame = PresetUtil.presetCanPlayKgniht();
    armyGame = PresetUtil.presetArmy();
  });

  group("Game custom tests", () {
    test("Game custom is created and card is deal (manually)", () {
      expect(customGame.players[0].getDeckLength(), 11);
      expect(customGame.players[1].getDeckLength(), 11);
      expect(customGame.players[2].getDeckLength(), 11);
      expect(customGame.players[3].getDeckLength(), 11);

      expect(customGame.battleField.getLength(), 4);

      expect(customGame.isSetup, true);
    });
  });

  group("Cards tests", () {
    group("Card Recruitment", () {
      test("Card Commander", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], CommanderCard);

        int indexCardCommander =
            CardsVerifier.getIndexCardByType(customGame.players[0], CommanderCard);

        Queue<GameCard> battleFieldBeforeShuffle =
            customGame.battleField.cards;
        customGame.getCurrentPlayer().playCard(customGame, indexCardCommander);
        Queue<GameCard> battleFieldAfterShuffle =
            customGame.battleField.cards;

        expect(
            battleFieldBeforeShuffle, isNot(equals(battleFieldAfterShuffle)));

        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
      });

      group("Cards Army", () {
        test("Card Guard (Counter OK)", () {
          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[0], ArcherCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[1], GuardCard);

          int indexCardArcher =
              CardsVerifier.getIndexCardByType(armyGame.players[0], ArcherCard);
          int indexCard2 = CardsVerifier.getIndexCardByType(armyGame.players[1], GuardCard);

          expect(armyGame.battleMode, false);

          armyGame.players[0].playCard(armyGame, indexCardArcher);
          expect(armyGame.battleMode, true);

          armyGame.nextTurn();

          armyGame.players[1].playCard(armyGame, indexCard2);
          expect(armyGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 2);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 5);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[0], ArcherCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[1], GuardCard);
        });

        test("Card Guard (Counter KO)", () {
          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[0], SwordsmanCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[1], GuardCard);

          int indexCard1 =
              CardsVerifier.getIndexCardByType(armyGame.players[0], SwordsmanCard);
          int indexCard2 = CardsVerifier.getIndexCardByType(armyGame.players[1], GuardCard);

          expect(armyGame.battleMode, false);

          armyGame.players[0].playCard(armyGame, indexCard1);
          expect(armyGame.battleMode, true);

          armyGame.nextTurn();

          armyGame.players[1].playCard(armyGame, indexCard2);
          expect(armyGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 3);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField,4);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[0], SwordsmanCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[1], GuardCard);
        });

        test("Card Spearman (Counter OK)", () {
          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[0], SwordsmanCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[1], ArcherCard);

          int indexCard1 =
              CardsVerifier.getIndexCardByType(armyGame.players[0], SwordsmanCard);
          int indexCard2 =
              CardsVerifier.getIndexCardByType(armyGame.players[1], ArcherCard);

          expect(armyGame.battleMode, false);

          armyGame.players[0].playCard(armyGame, indexCard1);
          expect(armyGame.battleMode, true);

          armyGame.nextTurn();

          armyGame.players[1].playCard(armyGame, indexCard2);
          expect(armyGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 2);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 5);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[0], SwordsmanCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[1], ArcherCard);
        });

        test("Card Spearman (Counter KO)", () {
          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[0], GuardCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[1], ArcherCard);

          int indexCard1 = CardsVerifier.getIndexCardByType(armyGame.players[0], GuardCard);
          int indexCard2 =
              CardsVerifier.getIndexCardByType(armyGame.players[1], ArcherCard);

          expect(armyGame.battleMode, false);

          armyGame.players[0].playCard(armyGame, indexCard1);
          expect(armyGame.battleMode, true);

          armyGame.nextTurn();

          armyGame.players[1].playCard(armyGame, indexCard2);
          expect(armyGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 3);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 4);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[0], GuardCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[1], ArcherCard);
        });

        test("Card Swordsman (Counter OK)", () {
          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[0], GuardCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[1], SwordsmanCard);

          int indexCard1 = CardsVerifier.getIndexCardByType(armyGame.players[0], GuardCard);
          int indexCard2 =
              CardsVerifier.getIndexCardByType(armyGame.players[1], SwordsmanCard);

          expect(armyGame.battleMode, false);

          armyGame.players[0].playCard(armyGame, indexCard1);
          expect(armyGame.battleMode, true);

          armyGame.nextTurn();

          armyGame.players[1].playCard(armyGame, indexCard2);
          expect(armyGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 2);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 5);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[0], GuardCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[1], SwordsmanCard);
        });

        test("Card Swordsman (Counter KO)", () {
          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[0], ArcherCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(armyGame.players[1], SwordsmanCard);

          int indexCard1 =
              CardsVerifier.getIndexCardByType(armyGame.players[0], ArcherCard);
          int indexCard2 =
              CardsVerifier.getIndexCardByType(armyGame.players[1], SwordsmanCard);

          expect(armyGame.battleMode, false);

          armyGame.players[0].playCard(armyGame, indexCard1);
          expect(armyGame.battleMode, true);

          armyGame.nextTurn();

          armyGame.players[1].playCard(armyGame, indexCard2);
          expect(armyGame.battleMode, true);

          CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 3);
          CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
          CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 4);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[0], ArcherCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(armyGame.players[1], SwordsmanCard);
        });
      });

      group("Cards Mage", () {
        test("Card Geomancer", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], GeomancerCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], GeomancerCard);

          int indexForGeomancerCard1 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), GeomancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForGeomancerCard1, 0);
          CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);

          customGame.nextTurn();

          int indexForGeomancerCard2 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), GeomancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForGeomancerCard2, 0);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 12);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], GeomancerCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], GeomancerCard);
        });

        test("Card Aeromancer", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], AeromancerCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], AeromancerCard);

          int indexForAeromancerCard1 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), AeromancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForAeromancerCard1, 0);
          CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);

          customGame.nextTurn();

          int indexForAeromancerCard2 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), AeromancerCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForAeromancerCard2, 0);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 12);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], AeromancerCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], AeromancerCard);
        });

        test("Card Arcanist", () {
          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], ArcanistCard);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], ArcanistCard);

          int indexForArcanistCard1 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), ArcanistCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForArcanistCard1, 0);
          CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 12);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 3);

          customGame.nextTurn();

          int indexForArcanistCard2 =
              CardsVerifier.getIndexCardByType(customGame.getCurrentPlayer(), ArcanistCard);

          customGame
              .getCurrentPlayer()
              .playCardWithOneTarget(customGame, indexForArcanistCard2, 0);

          CardsVerifier.verifyPlayerNbCard(customGame.players[0], 14);
          CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
          CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 2);
          CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], ArcanistCard);
          CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], ArcanistCard);
        });
      });

      test("Card Thielf", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], ThiefCard);

        int indexCard1 = CardsVerifier.getIndexCardByType(customGame.players[0], ThiefCard);

        customGame
            .getCurrentPlayer()
            .playCardWithTwoTargets(customGame, indexCard1, 0, 1);

        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      });
    });

    group("Card Triad", () {
      test("Card Herald Disease", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], DiseaseHeraldCard);

        int indexCardDiseaseHerald =
          CardsVerifier.getIndexCardByType(customGame.players[0], DiseaseHeraldCard);

        customGame
            .getCurrentPlayer()
            .playCardWithOneTarget(customGame, indexCardDiseaseHerald, 1);

        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], DiseaseHeraldCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], PlagueKnightCard);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], PlagueKnightCard);
      });

      test("Card Herald Chaos", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[2], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[2], ChaosHeraldCard);

        int indexCardChaosHerald =
        CardsVerifier.getIndexCardByType(customGame.players[2], ChaosHeraldCard);

        customGame.currentPlayerTurn = 2;

        customGame
            .getCurrentPlayer()
            .playCardWithOneTarget(customGame, indexCardChaosHerald, 1);

        CardsVerifier.verifyPlayerNbCard(customGame.players[2], 9);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[2], ChaosHeraldCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[2], WarKnightCard);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], WarKnightCard);
      });

      test("Card Herald Power", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[3], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[3], PowerHeraldCard);

        int indexCardPowerHerald =
        CardsVerifier.getIndexCardByType(customGame.players[3], PowerHeraldCard);

        customGame.currentPlayerTurn = 3;

        customGame
            .getCurrentPlayer()
            .playCardWithOneTarget(customGame, indexCardPowerHerald, 1);

        CardsVerifier.verifyPlayerNbCard(customGame.players[3], 9);
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[3], PowerHeraldCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[3], ConquestKnightCard);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], ConquestKnightCard);
      });

      test("Card Herald Suffering", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], SufferingHeraldCard);

        int indexCardSufferingHerald =
        CardsVerifier.getIndexCardByType(customGame.players[1], SufferingHeraldCard);

        customGame.currentPlayerTurn = 1;

        customGame
            .getCurrentPlayer()
            .playCardWithOneTarget(customGame, indexCardSufferingHerald, 0);

        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 9);
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 12);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], SufferingHeraldCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], FamineKnightCard);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], FamineKnightCard);
      });

      test("Card Saint Healing", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], HealingSaintCard);

        int indexCardHealingSaint =
        CardsVerifier.getIndexCardByType(customGame.players[0], HealingSaintCard);

        customGame
            .getCurrentPlayer()
            .playCardWithoutTarget(customGame, indexCardHealingSaint);

        CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 6);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], HealingSaintCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], PlagueKnightCard);
      });

      test("Card Saint Abundance", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], AbundanceSaintCard);

        int indexCardAbundanceSaint =
        CardsVerifier.getIndexCardByType(customGame.players[1], AbundanceSaintCard);

        customGame.currentPlayerTurn = 1;

        customGame
            .getCurrentPlayer()
            .playCardWithoutTarget(customGame, indexCardAbundanceSaint);

        CardsVerifier.verifyPlayerNbCard(customGame.players[1], 9);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 6);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], AbundanceSaintCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[1], FamineKnightCard);
      });

      test("Card Saint Peace", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[2], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[2], PeaceSaintCard);

        int indexCardPeaceSaint =
        CardsVerifier.getIndexCardByType(customGame.players[2], PeaceSaintCard);

        customGame.currentPlayerTurn = 2;

        customGame
            .getCurrentPlayer()
            .playCardWithoutTarget(customGame, indexCardPeaceSaint);

        CardsVerifier.verifyPlayerNbCard(customGame.players[2], 9);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 6);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[2], PeaceSaintCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[2], WarKnightCard);
      });

      test("Card Saint Prosperity", () {
        CardsVerifier.verifyPlayerNbCard(customGame.players[3], 11);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
        CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[3], ProsperitySaintCard);

        int indexCardProsperitySaint =
        CardsVerifier.getIndexCardByType(customGame.players[3], ProsperitySaintCard);

        customGame.currentPlayerTurn = 3;

        customGame
            .getCurrentPlayer()
            .playCardWithoutTarget(customGame, indexCardProsperitySaint);

        CardsVerifier.verifyPlayerNbCard(customGame.players[3], 9);
        CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 6);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[3], ProsperitySaintCard);
        CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[3], ConquestKnightCard);
      });
    });

    group("Cursed Knight Card", () {
      test("Can play Cursed Knight", () {
        CardsVerifier.verifyIfCardTypeIsInDeck(knightGame.players[0], WarKnightCard);

        int indexCardWarKnight =
          CardsVerifier.getIndexCardByType(knightGame.players[0], WarKnightCard);

        expect(knightGame.players[0].deck[indexCardWarKnight].canBePlayed(knightGame), isTrue);
      });

      test("Can't play Cursed Knight", () {
        CardsVerifier.verifyIfCardTypeIsInDeck(knightGame.players[1], FamineKnightCard);

        knightGame.currentPlayerTurn = 1;

        int indexCardWarKnight =
          CardsVerifier.getIndexCardByType(knightGame.players[1], FamineKnightCard);

        expect(knightGame.players[1].deck[indexCardWarKnight].canBePlayed(knightGame), isFalse);
      });
    });
  });
}
