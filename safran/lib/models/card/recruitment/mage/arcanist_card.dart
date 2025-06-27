import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/card_info.dart';
import '../../dealer.dart';
import '../../draw_position_enum.dart';
import '../../game_card.dart';
import 'mage_card.dart';

class ArcanistCard extends MageCard {
  ArcanistCard()
      : super(CardInfo.arcanist);

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
