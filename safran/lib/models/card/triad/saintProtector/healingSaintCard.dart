import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';
import '../../game_card.dart';

class HealingSaintCard extends SaintProtectorCard{
  HealingSaintCard()
      : super(NameCardConstant.HEALINGSAINT, DescriptionCardConstant.HEALINGSAINT,
      PictureCardConstant.HEALINGSAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(PlagueKnightCard)) {
        GameCard.correctNbTargets(0, targets);
        Dealer.transferCardPlayerToBattleField(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(PlagueKnightCard),
            game.battleField);
      }
    } catch (e) {
      Logger.error("Error while playing HealingSaintCard: $e");
      rethrow;
    }
  }
}