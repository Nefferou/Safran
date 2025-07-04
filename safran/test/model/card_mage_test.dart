import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/card/recruitment/mage/aeromancer_card.dart';
import 'package:safran/entities/card/recruitment/mage/arcanist_card.dart';
import 'package:safran/entities/card/recruitment/mage/geomancer_card.dart';
import 'package:safran/entities/game.dart';
import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
  });

  group("Cards Mage tests", () {
    test("Card Geomancer", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], GeomancerCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[1], GeomancerCard);

      int indexForGeomancerCard1 = CardsVerifier.getIndexCardByType(
          customGame.getCurrentPlayer(), GeomancerCard);

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexForGeomancerCard1, 0);
      CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);

      customGame.nextTurn();

      int indexForGeomancerCard2 = CardsVerifier.getIndexCardByType(
          customGame.getCurrentPlayer(), GeomancerCard);

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexForGeomancerCard2, 0);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 12);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[0], GeomancerCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[1], GeomancerCard);
    });

    test("Card Aeromancer", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], AeromancerCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[1], AeromancerCard);

      int indexForAeromancerCard1 = CardsVerifier.getIndexCardByType(
          customGame.getCurrentPlayer(), AeromancerCard);

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexForAeromancerCard1, 0);
      CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);

      customGame.nextTurn();

      int indexForAeromancerCard2 = CardsVerifier.getIndexCardByType(
          customGame.getCurrentPlayer(), AeromancerCard);

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexForAeromancerCard2, 0);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 12);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], AeromancerCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[1], AeromancerCard);
    });

    test("Card Arcanist", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], ArcanistCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[1], ArcanistCard);

      int indexForArcanistCard1 = CardsVerifier.getIndexCardByType(
          customGame.getCurrentPlayer(), ArcanistCard);

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexForArcanistCard1, 0);
      CardsVerifier.verifyPlayerNbCard(customGame.getCurrentPlayer(), 12);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 3);

      customGame.nextTurn();

      int indexForArcanistCard2 = CardsVerifier.getIndexCardByType(
          customGame.getCurrentPlayer(), ArcanistCard);

      customGame
          .getCurrentPlayer()
          .playCardWithOneTarget(customGame, indexForArcanistCard2, 0);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 14);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 2);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], ArcanistCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[1], ArcanistCard);
    });
  });
} 