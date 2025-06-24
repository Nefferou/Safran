import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';
import '../../draw_position_enum.dart';
import '../../game_card.dart';
import 'mageCard.dart';

class ArcanistCard extends MageCard {
  ArcanistCard()
      : super(NameCardConstant.ARCANIST, DescriptionCardConstant.ARCANIST,
            PictureCardConstant.ARCANIST);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      Dealer.transferCardBattleFieldToPlayer(
          game.battleField, game.players[targets[0]], DrawPositionEnum.both);
    } catch (e) {
      Logger.error("Error while playing Arcanist: $e");
      rethrow;
    }
  }
}
