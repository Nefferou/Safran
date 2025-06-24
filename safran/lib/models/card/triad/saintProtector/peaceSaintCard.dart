import 'package:safran/models/card/triad/cursedKnight/warKnightCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';
import '../../game_card.dart';

class PeaceSaintCard extends SaintProtectorCard{
  PeaceSaintCard()
      : super(NameCardConstant.PEACESAINT, DescriptionCardConstant.PEACESAINT,
      PictureCardConstant.PEACESAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(WarKnightCard)) {
        GameCard.correctNbTargets(0, targets);
        Dealer.transferCardPlayerToBattleField(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(WarKnightCard),
            game.getBattleField());
      }
    } catch (e) {
      Logger.error("Error while playing PeaceSaintCard: $e");
      rethrow;
    }
  }
}