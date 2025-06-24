import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';
import '../../draw_position_enum.dart';
import '../../game_card.dart';
import 'mageCard.dart';

class GeomancerCard extends MageCard {
  GeomancerCard()
      : super(NameCardConstant.GEOMANCER, DescriptionCardConstant.GEOMANCER,
            PictureCardConstant.GEOMANCER);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      Dealer.transferCardBattleFieldToPlayer(
          game.battleField, game.players[targets[0]], DrawPositionEnum.bottom);
    } catch (e) {
      Logger.error("Error while playing Geomancer: $e");
      rethrow;
    }
  }
}