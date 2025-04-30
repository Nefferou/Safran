import 'package:safran/models/card/draw_position_enum.dart';
import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import 'mageCard.dart';

class AeromancerCard extends MageCard {
  AeromancerCard()
      : super(NameCardConstant.AEROMANCER, DescriptionCardConstant.AEROMANCER,
            PictureCardConstant.AEROMANCER);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (targets.length != 1) {
      throw Exception("Aeromancer : Invalid number of target");
    } else if (activateEffect) {
      game.transferCardBattleFieldToPlayer(
          game.battleField, targets[0], DrawPositionEnum.TOP);
    }
  }
}
