import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/card/recruitment/commander_card.dart';
import 'package:safran/models/game.dart';
import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
  });

  group("Card Commander", () {
    test("Card Commander", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], CommanderCard);

      int indexCardCommander = CardsVerifier.getIndexCardByType(
          customGame.players[0], CommanderCard);

      var battleFieldBeforeShuffle = customGame.battleField.cards;
      customGame.getCurrentPlayer().playCard(customGame, indexCardCommander);
      var battleFieldAfterShuffle = customGame.battleField.cards;

      expect(
          battleFieldBeforeShuffle, isNot(equals(battleFieldAfterShuffle)));

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          customGame.players[0], CommanderCard);
    });
  });
} 