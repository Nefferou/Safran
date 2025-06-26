import 'package:safran/models/card/recruitment/army/armyCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../../player.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';
import '../../game_card.dart';

class ArcherCard extends ArmyCard {
  ArcherCard()
      : super(NameCardConstant.SPEARMAN, DescriptionCardConstant.SPEARMAN,
            PictureCardConstant.SPEARMAN);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (game.battleMode &&
          game.battleField.getUpCard().runtimeType == SwordsmanCard) {
        GameCard.correctNbTargets(0, targets);
        Player previousPlayer = game.players[game.getPreviousPlayerTurnIndex()];
        Logger.info("Player ${previousPlayer.userName} is countered by Guard");
        Dealer.transferCardPlayerToBattleField(
            previousPlayer, previousPlayer.discardCard(game), game.battleField);
      }
      game.battleMode = true;
    } catch (e) {
      Logger.error("Error while playing SpearmanCard: $e");
      rethrow;
    }
  }
}
