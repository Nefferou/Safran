import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class DiseaseHeraldCard extends FateHeraldCard{
  DiseaseHeraldCard()
      : super(NameCardConstant.DISEASEHERALD, DescriptionCardConstant.DISEASEHERALD,
      PictureCardConstant.DISEASEHERALD);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (activateEffect &&
        game.getCurrentPlayer().haveCardTypeInDeck(PlagueKnightCard)) {
      if (targets.length != 1) {
        throw Exception("DiseaseHerald : Invalid number of target");
      } else {
        game.transferCardPlayerToPlayer(
            game.getCurrentPlayerIndex(),
            game.getCurrentPlayer().getIndexCardInDeck(PlagueKnightCard),
            targets[0],
            canBeKill: false);
      }
    }
  }
}