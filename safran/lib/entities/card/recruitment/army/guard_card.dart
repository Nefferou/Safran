import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/entities/card/recruitment/army/army_card.dart';
import 'package:safran/entities/card/recruitment/army/archer_card.dart';
import 'package:safran/services/logger.dart';

import '../../../game.dart';
import '../../../player.dart';
import '../../game_card.dart';

class GuardCard extends ArmyCard {
  GuardCard() : super(CardInfo.guard);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (game.battleMode &&
          game.battleField.getUpCard().runtimeType == ArcherCard) {
        GameCard.correctNbTargets(0, targets);
        Player previousPlayer = game.players[game.getPreviousPlayerTurnIndex()];
        Logger.info("Player ${previousPlayer.userName} is countered by Guard");
        previousPlayer.discardCard(game);
      }
      game.battleMode = true;
    } catch (e) {
      Logger.error("Error while playing GuardCard: $e");
      rethrow;
    }
  }
}
