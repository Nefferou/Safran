import 'package:safran/models/card/triad/cursedKnight/warKnightCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class ChaosHeraldCard extends FateHeraldCard {
  ChaosHeraldCard()
      : super(NameCardConstant.CHAOSHERALD, DescriptionCardConstant.CHAOSHERALD,
            PictureCardConstant.CHAOSHERALD);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (activateEffect &&
        game.getCurrentPlayer().haveCardTypeInDeck(WarKnightCard)) {
      if (targets.length != 1) {
        throw Exception("ChaosHerald : Invalid number of target");
      } else {
        game.transferCardPlayerToPlayer(
            game.getCurrentPlayerIndex(),
            game.getCurrentPlayer().getIndexCardInDeck(WarKnightCard),
            targets[0]);
      }
    }
  }
}
