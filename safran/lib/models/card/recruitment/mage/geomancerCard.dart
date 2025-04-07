import '../../../game.dart';
import '../../../logger.dart';
import '../../../player.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import '../../draw_position_enum.dart';
import 'mageCard.dart';

class GeomancerCard extends MageCard {
  GeomancerCard()
      : super(NameCardConstant.GEOMANCER, DescriptionCardConstant.GEOMANCER,
      PictureCardConstant.GEOMANCER);

  @override
  play(Game game, [List<int> targets = const []]) {
    // Verify if player index is provided
    if (targets.isEmpty) {
      Logger.warning("Geomancer : Invalid target");
      throw Exception("Invalid target");
    } else {
      game.transferCardBattleFieldToPlayer(game.battleField,
          targets[0], DrawPositionEnum.BOTTOM);
    }
  }
}