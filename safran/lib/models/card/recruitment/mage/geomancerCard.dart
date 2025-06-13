import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../draw_position_enum.dart';
import 'mageCard.dart';

class GeomancerCard extends MageCard {
  GeomancerCard()
      : super(NameCardConstant.GEOMANCER, DescriptionCardConstant.GEOMANCER,
            PictureCardConstant.GEOMANCER);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (targets.length != 1) {
      throw Exception("Geomancer : Invalid number of target");
    } else if (activateEffect) {
      game.transferCardBattleFieldToPlayer(
          game.battleField, targets[0], DrawPositionEnum.BOTTOM);
    }
  }
}