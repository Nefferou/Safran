import 'package:safran/models/card/drawPositionEnum.dart';
import '../../../game.dart';
import '../../../player.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'mageCard.dart';

class AeromancerCard extends MageCard {
  AeromancerCard()
      : super(NameCardConstant.AEROMANCER, DescriptionCardConstant.AEROMANCER,
      PictureCardConstant.AEROMANCER);

  play(Game game, [List<int> targets = const []]) {
    game.transferCardBattleFieldToPlayer(game.battleField,
        targets[0], DrawPositionEnum.TOP);
  }
}
