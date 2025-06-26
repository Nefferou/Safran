import 'package:safran/models/card/constant/description_card_constant.dart';
import 'package:safran/models/card/constant/name_card_constant.dart';
import 'package:safran/models/card/constant/picture_card_constant.dart';
import 'package:safran/models/card/recruitment/army/army_card.dart';
import 'package:safran/models/card/recruitment/army/archer_card.dart';
import 'package:safran/models/logger.dart';

import '../../../game.dart';
import '../../../player.dart';
import '../../game_card.dart';

class GuardCard extends ArmyCard {
  GuardCard()
      : super(NameCardConstant.GARDE, DescriptionCardConstant.GARDE,
            PictureCardConstant.GARDE);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (game.battleMode &&
          game.battleField.getUpCard().runtimeType == ArcherCard) {
        GameCard.correctNbTargets(0, targets);
        Player previousPlayer = game.players[game.getPreviousPlayerTurnIndex()];
        Logger.info("Player ${previousPlayer.userName} is countered by Guard");
        previousPlayer.discardCard(game);
      }
      game.battleMode = true;
    } catch (e) {
      Logger.error("Error while playing GuardCard: $e");
      rethrow;
    }
  }
}
