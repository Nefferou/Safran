import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/card/triad/cursedKnight/conquest_knight_card.dart';
import 'package:safran/models/card/triad/cursedKnight/famine_knight_card.dart';
import 'package:safran/models/card/triad/cursedKnight/plague_knight_card.dart';
import 'package:safran/models/card/triad/cursedKnight/war_knight_card.dart';
import 'package:safran/models/card/triad/fateHerald/chaos_herald_card.dart';
import 'package:safran/models/card/triad/fateHerald/disease_herald_card.dart';
import 'package:safran/models/card/triad/fateHerald/power_herald_card.dart';
import 'package:safran/models/card/triad/fateHerald/suffering_herald_card.dart';
import 'package:safran/models/game.dart';
import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
  });

  group("Card Herald", () {
    test("Card Herald Disease", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], DiseaseHeraldCard);

      int indexCardDiseaseHerald = CardsVerifier.getIndexCardByType(
          customGame.players[0], DiseaseHeraldCard);

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexCardDiseaseHerald, 1);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[0], DiseaseHeraldCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[0], PlagueKnightCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[1], PlagueKnightCard);
    });

    test("Card Herald Chaos", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[2], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[2], ChaosHeraldCard);

      int indexCardChaosHerald = CardsVerifier.getIndexCardByType(
          customGame.players[2], ChaosHeraldCard);

      customGame.currentPlayerTurn = 2;

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexCardChaosHerald, 1);

      CardsVerifier.verifyPlayerNbCard(customGame.players[2], 9);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[2], ChaosHeraldCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[2], WarKnightCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[1], WarKnightCard);
    });

    test("Card Herald Power", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[3], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[3], PowerHeraldCard);

      int indexCardPowerHerald = CardsVerifier.getIndexCardByType(
          customGame.players[3], PowerHeraldCard);

      customGame.currentPlayerTurn = 3;

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexCardPowerHerald, 1);

      CardsVerifier.verifyPlayerNbCard(customGame.players[3], 9);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[3], PowerHeraldCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[3], ConquestKnightCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[1], ConquestKnightCard);
    });

    test("Card Herald Suffering", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[1], SufferingHeraldCard);

      int indexCardSufferingHerald = CardsVerifier.getIndexCardByType(
          customGame.players[1], SufferingHeraldCard);

      customGame.currentPlayerTurn = 1;

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexCardSufferingHerald, 0);

      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 9);
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 12);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[1], SufferingHeraldCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[1], FamineKnightCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], FamineKnightCard);
    });
  });
}
