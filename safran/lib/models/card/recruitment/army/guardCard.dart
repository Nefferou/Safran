import 'package:safran/models/card/constant/descriptionCardConstante.dart';
import 'package:safran/models/card/constant/nameCardConstante.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/army/armyCard.dart';
import 'package:safran/models/card/recruitment/army/spearmanCard.dart';
import 'package:safran/models/logger.dart';

import '../../../game.dart';

class GuardCard extends ArmyCard {
  GuardCard()
      : super(NameCardConstant.GARDE, DescriptionCardConstant.GARDE,
            PictureCardConstant.GARDE);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (targets.isNotEmpty) {
      throw Exception("Guard : Invalid number of target");
    } else if (game.battleMode &&
        game.battleField.getUpCard().runtimeType == SpearmanCard) {
      int playerIndex = game.getPreviousPlayerTurnIndex();

      Logger.info(
          "Player ${game.players[game.getPreviousPlayerTurnIndex()].userName} is countered by Guard");
      game.transferCardPlayerToBattleField(playerIndex,
          game.players[playerIndex].discardCard(game), game.battleField);
    }
    game.setBattleMode(true);
  }
}
