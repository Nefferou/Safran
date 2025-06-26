import 'package:safran/models/card/recruitment/army/army_card.dart';
import 'package:safran/models/card/recruitment/army/guard_card.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../../player.dart';
import '../../constant/description_card_constant.dart';
import '../../constant/name_card_constant.dart';
import '../../constant/picture_card_constant.dart';
import '../../game_card.dart';

class SwordsmanCard extends ArmyCard {
  SwordsmanCard()
      : super(NameCardConstant.SWORSDMAN, DescriptionCardConstant.SWORSDMAN,
            PictureCardConstant.SWORSDMAN);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (game.battleMode &&
          game.battleField.getUpCard().runtimeType == GuardCard) {
        GameCard.correctNbTargets(0, targets);
        Player previousPlayer = game.players[game.getPreviousPlayerTurnIndex()];
        Logger.info("Player ${previousPlayer.userName} is countered by Guard");
        previousPlayer.discardCard(game);
      }
      game.battleMode = true;
    } catch (e) {
      Logger.error("Error while playing SwordsmanCard: $e");
      rethrow;
    }
  }
}
