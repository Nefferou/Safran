import 'package:safran/models/card/recruitment/army/armyCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
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
          game.battleField
              .getUpCard()
              .runtimeType == SwordsmanCard) {
        GameCard.correctNbTargets(0, targets);
        Logger.info(
            "Player ${game
                .getPreviousPlayerTurn()
                .userName} is countered by Guard");
        Dealer.transferCardPlayerToBattleField(game.getPreviousPlayerTurn(),
            game.getPreviousPlayerTurn().discardCard(game), game.battleField);
      }
      game.setBattleMode(true);
    } catch (e) {
      Logger.error("Error while playing SpearmanCard: $e");
      rethrow;
    }
  }
}
