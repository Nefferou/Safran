import '../../../player.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import '../../drawPositionEnum.dart';
import 'mageCard.dart';

class GeomancerCard extends MageCard {
  GeomancerCard(game)
      : super(NameCardConstant.GEOMANCER, DescriptionCardConstant.GEOMANCER,
      PictureCardConstant.GEOMANCER, game);

  play(Player player) {
    game.transferCardBattleFieldToPlayer(game.battleField,
        player, DrawPositionEnum.BOTTOM);
  }
}