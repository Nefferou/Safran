import '../../../game.dart';
import '../../../logger.dart';
import '../../../player.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import '../../draw_position_enum.dart';
import 'mageCard.dart';

class ArcanistCard extends MageCard {
  ArcanistCard()
      : super(NameCardConstant.ARCANIST, DescriptionCardConstant.ARCANIST,
      PictureCardConstant.ARCANIST);

  @override
  play(Game game, [List<int> targets = const []]) {
    // Verify if player index is provided
    if (targets.isEmpty) {
      Logger.warning("Arcanist: Invalid target");
      throw Exception("Invalid target");
    } else {
      game.transferCardBattleFieldToPlayer(game.battleField,
          targets[0], DrawPositionEnum.BOTH);
    }
  }
}
