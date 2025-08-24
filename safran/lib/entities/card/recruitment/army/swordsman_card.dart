import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/entities/card/recruitment/army/army_card.dart';
import 'package:safran/entities/card/recruitment/army/guard_card.dart';

import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../../../entities/player.dart';
import '../../game_card.dart';

class SwordsmanCard extends ArmyCard {
  SwordsmanCard()
      : super(CardInfo.swordsman);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) async {
    try {
      if (game.battleMode &&
          game.battleField.getUpCard().runtimeType == GuardCard) {
        GameCard.correctNbTargets(0, targets);
        Player previousPlayer = game.players[game.getPreviousPlayerTurnIndex()];
        Logger.info("Player ${previousPlayer.userName} is countered by Guard");
        await previousPlayer.discardCard(game);
      }
      game.battleMode = true;
    } catch (e) {
      Logger.error("Error while playing SwordsmanCard: $e");
      rethrow;
    }
  }
}
