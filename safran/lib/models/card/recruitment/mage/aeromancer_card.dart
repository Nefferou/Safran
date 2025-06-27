import 'package:safran/models/card/constant/card_info.dart';
import 'package:safran/models/card/dealer.dart';
import 'package:safran/models/card/draw_position_enum.dart';
import '../../../game.dart';
import '../../../logger.dart';
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
