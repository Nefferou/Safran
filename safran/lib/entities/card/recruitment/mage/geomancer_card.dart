import 'package:safran/core/constants/card_info_constant.dart';

import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../../../services/dealer.dart';
import '../../../../core/constants/draw_position_enum.dart';
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