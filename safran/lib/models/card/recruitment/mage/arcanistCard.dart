import '../../../game.dart';
import '../../../player.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import '../../drawPositionEnum.dart';
import 'mageCard.dart';

class ArcanistCard extends MageCard {
  ArcanistCard()
      : super(NameCardConstant.ARCANIST, DescriptionCardConstant.ARCANIST,
      PictureCardConstant.ARCANIST);

  play(Game game, [List<int> targets = const []]) {
    game.transferCardBattleFieldToPlayer(game.battleField,
        targets[0], DrawPositionEnum.BOTH);
  }
}
