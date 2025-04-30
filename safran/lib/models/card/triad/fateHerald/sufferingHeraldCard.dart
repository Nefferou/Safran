import 'package:safran/models/card/triad/cursedKnight/famineKnightCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class SufferingHeraldCard extends FateHeraldCard{
  SufferingHeraldCard()
      : super(NameCardConstant.SUFFERINGHERALD, DescriptionCardConstant.SUFFERINGHERALD,
      PictureCardConstant.SUFFERINGHERALD);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (activateEffect &&
        game.getCurrentPlayer().haveCardTypeInDeck(FamineKnightCard)) {
      if (targets.length != 1) {
        throw Exception("SufferingHerald : Invalid number of target");
      } else {
        game.transferCardPlayerToPlayer(
            game.getCurrentPlayerIndex(),
            game.getCurrentPlayer().getIndexCardInDeck(FamineKnightCard),
            targets[0]);
      }
    }
  }
}