import '../../../player.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import '../../drawPositionEnum.dart';
import 'mageCard.dart';

class ArcanistCard extends MageCard {
  ArcanistCard(game)
      : super(NameCardConstant.ARCANIST, DescriptionCardConstant.ARCANIST,
      PictureCardConstant.ARCANIST, game);

  play(Player player) {
    game.transferCardBattleFieldToPlayer(game.battleField,
        player, DrawPositionEnum.BOTH);
  }
}
