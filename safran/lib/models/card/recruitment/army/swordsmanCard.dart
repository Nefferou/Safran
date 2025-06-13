import 'package:safran/models/card/recruitment/army/armyCard.dart';
import 'package:safran/models/card/recruitment/army/guardCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';

class SwordsmanCard extends ArmyCard {
  SwordsmanCard()
      : super(NameCardConstant.SWORSDMAN, DescriptionCardConstant.SWORSDMAN,
            PictureCardConstant.SWORSDMAN);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (targets.isNotEmpty) {
      throw Exception("Swordsman : Invalid number of target");
    } else if (game.battleMode &&
        game.battleField.getUpCard().runtimeType == GuardCard) {
      int playerIndex = game.getPreviousPlayerTurnIndex();

      Logger.info(
          "Player ${game.players[game.getPreviousPlayerTurnIndex()].userName} is countered by Swordsman");

      game.transferCardPlayerToBattleField(playerIndex,
          game.players[playerIndex].discardCard(game), game.battleField);
    }
    game.setBattleMode(true);
  }
}