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
import 'package:mockito/mockito.dart';

import 'test_player.dart';

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
      ProsperitySaintCard(),
      ConquestKnightCard()
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
      HealingSaintCard(),
      PlagueKnightCard()
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
    customGame.battleField.cards.addAll(
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
    playerWithConquestKnight = TestPlayer("PlayerWithConquestKnight");
    playerWithFamineKnight = TestPlayer("PlayerWithFamineKnight");
    playerWithPlagueKnight = TestPlayer("PlayerWithPlagueKnight");
    playerWithWarKnight = TestPlayer("PlayerWithWarKnight");

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

      expect(customGame.battleField.getLength(), 4);

      expect(customGame.isSetup, true);
    });
  });

  group("Cards tests", ()
  {
    test("Card Commander", () {
      verifyPlayerNbCard(customGame.players[0], 11);
      verifyBattleFieldNbCard(customGame.battleField, 4);
      verifyIfCardTypeIsInDeck(customGame.players[0], CommanderCard);

      int indexCard = getIndexCardByType(customGame.players[0], CommanderCard);

      Queue<GameCard> battleFieldBeforeShuffle = customGame.battleField.cards;
      customGame.players[0].playCard(customGame, indexCard);
      Queue<GameCard> battleFieldAfterShuffle = customGame.battleField.cards;

      expect(battleFieldBeforeShuffle, isNot(equals(battleFieldAfterShuffle)));

      verifyPlayerNbCard(customGame.players[0], 10);
      verifyBattleFieldNbCard(customGame.battleField, 5);
      verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
    });

    group("Cards Army", () {
      test("Card Guard (Counter OK)", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], SpearmanCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], GuardCard);

        int indexCard1 = getIndexCardByType(
            customGame.players[0], SpearmanCard);
        int indexCard2 = getIndexCardByType(customGame.players[1], GuardCard);

        // Choose the card to discard
        (customGame.players[0] as TestPlayer).indexToDiscard =
            getIndexCardByType(customGame.players[0], CommanderCard);

        expect(customGame.battleMode, false);

        customGame.players[0].playCard(customGame, indexCard1);
        expect(customGame.battleMode, true);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2);
        expect(customGame.battleMode, true);

        verifyPlayerNbCard(customGame.players[0], 9);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 7);
        verifyIfCardTypeIsntInDeck(customGame.players[0], SpearmanCard);
        verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], GuardCard);
      });

      test("Card Guard (Counter KO)", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], SwordsmanCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], GuardCard);

        int indexCard1 = getIndexCardByType(
            customGame.players[0], SwordsmanCard);
        int indexCard2 = getIndexCardByType(customGame.players[1], GuardCard);

        expect(customGame.battleMode, false);

        customGame.players[0].playCard(customGame, indexCard1);
        expect(customGame.battleMode, true);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2);
        expect(customGame.battleMode, true);

        verifyPlayerNbCard(customGame.players[0], 10);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 6);
        verifyIfCardTypeIsntInDeck(customGame.players[0], SwordsmanCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], GuardCard);
      });

      test("Card Spearman (Counter OK)", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], SwordsmanCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], SpearmanCard);

        int indexCard1 = getIndexCardByType(
            customGame.players[0], SwordsmanCard);
        int indexCard2 = getIndexCardByType(
            customGame.players[1], SpearmanCard);

        // Choose the card to discard
        (customGame.players[0] as TestPlayer).indexToDiscard =
            getIndexCardByType(customGame.players[0], CommanderCard);

        expect(customGame.battleMode, false);

        customGame.players[0].playCard(customGame, indexCard1);
        expect(customGame.battleMode, true);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2);
        expect(customGame.battleMode, true);

        verifyPlayerNbCard(customGame.players[0], 9);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 7);
        verifyIfCardTypeIsntInDeck(customGame.players[0], SwordsmanCard);
        verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], SpearmanCard);
      });

      test("Card Spearman (Counter KO)", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], SpearmanCard);

        int indexCard1 = getIndexCardByType(customGame.players[0], GuardCard);
        int indexCard2 = getIndexCardByType(
            customGame.players[1], SpearmanCard);

        expect(customGame.battleMode, false);

        customGame.players[0].playCard(customGame, indexCard1);
        expect(customGame.battleMode, true);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2);
        expect(customGame.battleMode, true);

        verifyPlayerNbCard(customGame.players[0], 10);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 6);
        verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], SpearmanCard);
      });

      test("Card Swordsman (Counter OK)", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], SwordsmanCard);

        int indexCard1 = getIndexCardByType(customGame.players[0], GuardCard);
        int indexCard2 = getIndexCardByType(
            customGame.players[1], SwordsmanCard);

        // Choose the card to discard
        (customGame.players[0] as TestPlayer).indexToDiscard =
            getIndexCardByType(customGame.players[0], CommanderCard);

        expect(customGame.battleMode, false);

        customGame.players[0].playCard(customGame, indexCard1);
        expect(customGame.battleMode, true);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2);
        expect(customGame.battleMode, true);

        verifyPlayerNbCard(customGame.players[0], 9);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 7);
        verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
        verifyIfCardTypeIsntInDeck(customGame.players[0], CommanderCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], SwordsmanCard);
      });

      test("Card Swordsman (Counter KO)", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], SpearmanCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], SwordsmanCard);

        int indexCard1 = getIndexCardByType(
            customGame.players[0], SpearmanCard);
        int indexCard2 = getIndexCardByType(
            customGame.players[1], SwordsmanCard);

        expect(customGame.battleMode, false);

        customGame.players[0].playCard(customGame, indexCard1);
        expect(customGame.battleMode, true);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2);
        expect(customGame.battleMode, true);

        verifyPlayerNbCard(customGame.players[0], 10);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 6);
        verifyIfCardTypeIsntInDeck(customGame.players[0], SpearmanCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], SwordsmanCard);
      });
    });

    group("Cards Mage", () {
      test("Card Geomancer", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], GeomancerCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], GeomancerCard);

        int indexCard1 = getIndexCardByType(
            customGame.players[0], GeomancerCard);
        int indexCard2 = getIndexCardByType(
            customGame.players[1], GeomancerCard);

        customGame.players[0].playCard(customGame, indexCard1, [0]);
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2, [0]);

        verifyPlayerNbCard(customGame.players[0], 12);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsntInDeck(customGame.players[0], GeomancerCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], GeomancerCard);
      });

      test("Card Aeromancer", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], AeromancerCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], AeromancerCard);

        int indexCard1 = getIndexCardByType(
            customGame.players[0], AeromancerCard);
        int indexCard2 = getIndexCardByType(
            customGame.players[1], AeromancerCard);

        customGame.players[0].playCard(customGame, indexCard1, [0]);
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2, [0]);

        verifyPlayerNbCard(customGame.players[0], 12);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], AeromancerCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], AeromancerCard);
      });

      test("Card Arcanist", () {
        verifyPlayerNbCard(customGame.players[0], 11);
        verifyPlayerNbCard(customGame.players[1], 11);
        verifyBattleFieldNbCard(customGame.battleField, 4);
        verifyIfCardTypeIsInDeck(customGame.players[0], ArcanistCard);
        verifyIfCardTypeIsInDeck(customGame.players[1], ArcanistCard);

        int indexCard1 = getIndexCardByType(
            customGame.players[0], ArcanistCard);
        int indexCard2 = getIndexCardByType(
            customGame.players[1], ArcanistCard);

        customGame.players[0].playCard(customGame, indexCard1, [0]);
        verifyPlayerNbCard(customGame.players[0], 12);
        verifyBattleFieldNbCard(customGame.battleField, 3);

        customGame.nextTurn();

        customGame.players[1].playCard(customGame, indexCard2, [0]);

        verifyPlayerNbCard(customGame.players[0], 14);
        verifyPlayerNbCard(customGame.players[1], 10);
        verifyBattleFieldNbCard(customGame.battleField, 2);
        verifyIfCardTypeIsInDeck(customGame.players[0], ArcanistCard);
        verifyIfCardTypeIsntInDeck(customGame.players[1], ArcanistCard);
      });
    });
  });
}
