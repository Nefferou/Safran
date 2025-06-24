import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';
import '../../game_card.dart';
import 'fateHeraldCard.dart';

class PowerHeraldCard extends FateHeraldCard{
  PowerHeraldCard()
      : super(NameCardConstant.POWERHERALD, DescriptionCardConstant.POWERHERALD,
      PictureCardConstant.POWERHERALD);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(ConquestKnightCard)) {
        Dealer.transferCardPlayerToPlayer(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(ConquestKnightCard),
            game.players[targets[0]]);
      }
    } catch (e) {
      Logger.error("Error while playing PowerHeraldCard: $e");
      rethrow;
    }
  }
}