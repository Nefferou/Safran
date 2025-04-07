import 'package:safran/models/card/recruitment/army/armyCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class SpearmanCard extends ArmyCard {
  SpearmanCard()
      : super(NameCardConstant.SPEARMAN, DescriptionCardConstant.SPEARMAN,
      PictureCardConstant.SPEARMAN);

  @override
  play(Game game, [List<int> targets = const []]) {
    if(game.battleMode && game.battleField.getUpCard().runtimeType == SwordsmanCard) {
      int playerIndex = game.getPreviousPlayerTurnIndex();

      Logger.info("Player ${game.players[game.getPreviousPlayerTurnIndex()].userName} is countered by Spearman");
      game.transferCardPlayerToBattleField(
          playerIndex, game.players[playerIndex].discardCard(),
          game.battleField);
    }
    game.setBattleMode(true);
  }
}