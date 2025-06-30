import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/entities/card/recruitment/army/army_card.dart';
import 'package:safran/entities/card/recruitment/army/swordsman_card.dart';

import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../../../entities/player.dart';
import '../../../../entities/card/game_card.dart';

class ArcherCard extends ArmyCard {
  ArcherCard() : super(CardInfo.archer);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (game.battleMode &&
          game.battleField.getUpCard().runtimeType == SwordsmanCard) {
        GameCard.correctNbTargets(0, targets);
        Player previousPlayer = game.players[game.getPreviousPlayerTurnIndex()];
        Logger.info("Player ${previousPlayer.userName} is countered by Guard");
        previousPlayer.discardCard(game);
      }
      game.battleMode = true;
    } catch (e) {
      Logger.error("Error while playing SpearmanCard: $e");
      rethrow;
    }
  }
}
