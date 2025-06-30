import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/card/triad/cursedKnight/conquest_knight_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/famine_knight_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/plague_knight_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/war_knight_card.dart';
import 'package:safran/entities/card/triad/saintProtector/abundance_saint_card.dart';
import 'package:safran/entities/card/triad/saintProtector/healing_saint_card.dart';
import 'package:safran/entities/card/triad/saintProtector/peace_saint_card.dart';
import 'package:safran/entities/card/triad/saintProtector/prosperity_saint_card.dart';
import 'package:safran/entities/game.dart';
import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
  });

  group("Card Saint", () {
    test("Card Saint Healing", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], HealingSaintCard);

      int indexCardHealingSaint = CardsVerifier.getIndexCardByType(
          customGame.players[0], HealingSaintCard);

      customGame
          .getCurrentPlayer()
          .playCardWithoutTarget(customGame, indexCardHealingSaint);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 6);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[0], HealingSaintCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[0], PlagueKnightCard);
    });

    test("Card Saint Abundance", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[1], AbundanceSaintCard);

      int indexCardAbundanceSaint = CardsVerifier.getIndexCardByType(
          customGame.players[1], AbundanceSaintCard);

      customGame.currentPlayerTurn = 1;

      customGame
          .getCurrentPlayer()
          .playCardWithoutTarget(customGame, indexCardAbundanceSaint);

      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 9);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 6);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[1], AbundanceSaintCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[1], FamineKnightCard);
    });

    test("Card Saint Peace", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[2], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[2], PeaceSaintCard);

      int indexCardPeaceSaint = CardsVerifier.getIndexCardByType(
          customGame.players[2], PeaceSaintCard);

      customGame.currentPlayerTurn = 2;

      customGame
          .getCurrentPlayer()
          .playCardWithoutTarget(customGame, indexCardPeaceSaint);

      CardsVerifier.verifyPlayerNbCard(customGame.players[2], 9);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 6);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[2], PeaceSaintCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[2], WarKnightCard);
    });

    test("Card Saint Prosperity", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[3], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[3], ProsperitySaintCard);

      int indexCardProsperitySaint = CardsVerifier.getIndexCardByType(
          customGame.players[3], ProsperitySaintCard);

      customGame.currentPlayerTurn = 3;

      customGame
          .getCurrentPlayer()
          .playCardWithoutTarget(customGame, indexCardProsperitySaint);

      CardsVerifier.verifyPlayerNbCard(customGame.players[3], 9);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 6);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[3], ProsperitySaintCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[3], ConquestKnightCard);
    });
  });
}
