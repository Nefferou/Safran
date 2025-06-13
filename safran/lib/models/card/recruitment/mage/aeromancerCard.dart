import 'package:safran/models/card/drawPositionEnum.dart';
import '../../../player.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'mageCard.dart';

class AeromancerCard extends MageCard {
  AeromancerCard(game)
      : super(NameCardConstant.AEROMANCER, DescriptionCardConstant.AEROMANCER,
      PictureCardConstant.AEROMANCER, game);

  play(Player player) {
    game.transferCardBattleFieldToPlayer(game.battleField,
        player, DrawPositionEnum.TOP);
  }
}
