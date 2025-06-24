import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/triad/cursedKnight/famineKnightCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';

class AbundanceSaintCard extends SaintProtectorCard {
  AbundanceSaintCard()
      : super(
            NameCardConstant.ABUNDANCESAINT,
            DescriptionCardConstant.ABUNDANCESAINT,
            PictureCardConstant.ABUNDANCESAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(FamineKnightCard)) {
        GameCard.correctNbTargets(0, targets);
        Dealer.transferCardPlayerToBattleField(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(FamineKnightCard),
            game.getBattleField());
      }
    } catch (e) {
      Logger.error("Error while playing AbundanceSaintCard: $e");
      rethrow;
    }
  }
}
