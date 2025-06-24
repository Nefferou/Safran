import 'package:safran/models/card/dealer.dart';
import 'package:safran/models/card/triad/cursedKnight/warKnightCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../game_card.dart';
import 'fateHeraldCard.dart';

class ChaosHeraldCard extends FateHeraldCard {
  ChaosHeraldCard()
      : super(NameCardConstant.CHAOSHERALD, DescriptionCardConstant.CHAOSHERALD,
            PictureCardConstant.CHAOSHERALD);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(WarKnightCard)) {
        Dealer.transferCardPlayerToPlayer(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(WarKnightCard),
            game.players[targets[0]]);
      }
    } catch (e) {
      Logger.error("Error while playing ChaosHeraldCard: $e");
      rethrow;
    }
  }
}
