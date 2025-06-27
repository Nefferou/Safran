import 'package:safran/models/card/constant/card_info.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../dealer.dart';
import '../../draw_position_enum.dart';
import '../../game_card.dart';
import 'mage_card.dart';

class GeomancerCard extends MageCard {
  GeomancerCard()
      : super(CardInfo.geomancer);

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