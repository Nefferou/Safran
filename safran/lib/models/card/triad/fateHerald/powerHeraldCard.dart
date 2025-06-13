import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class PowerHeraldCard extends FateHeraldCard{
  PowerHeraldCard()
      : super(NameCardConstant.POWERHERALD, DescriptionCardConstant.POWERHERALD,
      PictureCardConstant.POWERHERALD);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (activateEffect &&
        game.getCurrentPlayer().haveCardTypeInDeck(ConquestKnightCard)) {
      if (targets.length != 1) {
        throw Exception("PowerHerald : Invalid number of target");
      } else {
        game.transferCardPlayerToPlayer(
            game.getCurrentPlayerIndex(),
            game.getCurrentPlayer().getIndexCardInDeck(ConquestKnightCard),
            targets[0]);
      }
    }
  }
}