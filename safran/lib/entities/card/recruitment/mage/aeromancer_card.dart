import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/services/dealer.dart';
import 'package:safran/core/constants/draw_position_enum.dart';
import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../game_card.dart';
import 'mage_card.dart';

class AeromancerCard extends MageCard {
  AeromancerCard()
      : super(CardInfo.aeromancer);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      Dealer.transferCardBattleFieldToPlayer(
          game.battleField, game.players[targets[0]], DrawPositionEnum.top);
    } catch (e) {
      Logger.error("Error while playing Aeromancer: $e");
      rethrow;
    }
  }
}
