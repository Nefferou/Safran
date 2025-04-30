import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../draw_position_enum.dart';
import 'mageCard.dart';

class ArcanistCard extends MageCard {
  ArcanistCard()
      : super(NameCardConstant.ARCANIST, DescriptionCardConstant.ARCANIST,
            PictureCardConstant.ARCANIST);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (targets.length != 1) {
      throw Exception("Arcanist : Invalid number of target");
    } else if (activateEffect) {
      game.transferCardBattleFieldToPlayer(
          game.battleField, targets[0], DrawPositionEnum.BOTH);
    }
  }
}
