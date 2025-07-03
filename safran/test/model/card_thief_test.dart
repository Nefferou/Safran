import 'package:flutter_test/flutter_test.dart';
import 'package:safran/core/constants/player_status_constant.dart';
import 'package:safran/entities/card/recruitment/thief_card.dart';
import 'package:safran/entities/game.dart';
import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;
  late Game robGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
    robGame = PresetUtil.presetRobPlagueKnight();
  });

  group("Card Thief", () {
    test("Card Thielf Standard play", () {
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

    test("Card Thielf rob Plague Knight", () {
      CardsVerifier.verifyPlayerNbCard(robGame.players[0], 3);
      CardsVerifier.verifyPlayerNbCard(robGame.players[1], 1);
      CardsVerifier.verifyBattleFieldNbCard(robGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(robGame.players[0], ThiefCard);

      int indexCard1 =
      CardsVerifier.getIndexCardByType(robGame.players[0], ThiefCard);

      robGame
          .getCurrentPlayer()
          .playCardWithTwoTargets(robGame, indexCard1, 0, 1);

      CardsVerifier.verifyPlayerNbCard(robGame.players[0], 3);
      CardsVerifier.verifyPlayerNbCard(robGame.players[1], 0);
      CardsVerifier.verifyBattleFieldNbCard(robGame.battleField, 5);
      expect(robGame.players[1].status, PlayerStatusConstant.dead);
    });
  });
} 