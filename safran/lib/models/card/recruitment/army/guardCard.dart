import 'package:safran/models/card/constant/descriptionCardConstant.dart';
import 'package:safran/models/card/constant/nameCardConstant.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/army/armyCard.dart';
import 'package:safran/models/card/recruitment/army/archerCard.dart';
import 'package:safran/models/logger.dart';

import '../../../game.dart';
import '../../dealer.dart';
import '../../game_card.dart';

class GuardCard extends ArmyCard {
  GuardCard()
      : super(NameCardConstant.GARDE, DescriptionCardConstant.GARDE,
            PictureCardConstant.GARDE);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (game.battleMode &&
          game.battleField.getUpCard().runtimeType == ArcherCard) {
        GameCard.correctNbTargets(0, targets);
        Logger.info(
            "Player ${game.getPreviousPlayerTurn().userName} is countered by Guard");
        Dealer.transferCardPlayerToBattleField(game.getPreviousPlayerTurn(),
            game.getPreviousPlayerTurn().discardCard(game), game.battleField);
      }
      game.setBattleMode(true);
    } catch (e) {
      Logger.error("Error while playing GuardCard: $e");
      rethrow;
    }
  }
}
