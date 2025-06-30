import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/card/recruitment/thief_card.dart';
import 'package:safran/entities/game.dart';
import '../../utils/cards_verifier.dart';
import '../../utils/preset_util.dart';

void main() {
  late Game customGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
  });

  group("Card Thief", () {
    test("Card Thielf", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          customGame.players[0], ThiefCard);

      int indexCard1 =
          CardsVerifier.getIndexCardByType(customGame.players[0], ThiefCard);

      customGame
          .getCurrentPlayer()
          .playCardWithTwoTargets(customGame, indexCard1, 0, 1);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
    });
  });
} 