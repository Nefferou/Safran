import 'package:safran/models/card/draw_position_enum.dart';
import '../../../game.dart';
import '../../../logger.dart';
import '../../../player.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'mageCard.dart';

class AeromancerCard extends MageCard {
  AeromancerCard()
      : super(NameCardConstant.AEROMANCER, DescriptionCardConstant.AEROMANCER,
      PictureCardConstant.AEROMANCER);

  @override
  play(Game game, [List<int> targets = const []]) {
    // Verify if player index is provided
    if (targets.isEmpty) {
      Logger.warning("AeromancerCard: Invalid target");
      throw Exception("Invalid target");
    } else {
      game.transferCardBattleFieldToPlayer(game.battleField,
          targets[0], DrawPositionEnum.TOP);
    }
  }
}
