import 'package:safran/models/card/triad/cursedKnight/famineKnightCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';
import '../../game_card.dart';
import 'fateHeraldCard.dart';

class SufferingHeraldCard extends FateHeraldCard{
  SufferingHeraldCard()
      : super(NameCardConstant.SUFFERINGHERALD, DescriptionCardConstant.SUFFERINGHERALD,
      PictureCardConstant.SUFFERINGHERALD);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(FamineKnightCard)) {
        Dealer.transferCardPlayerToPlayer(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(FamineKnightCard),
            game.players[targets[0]]);
      }
    } catch (e) {
      Logger.error("Error while playing SufferingHeraldCard: $e");
      rethrow;
    }
  }
}