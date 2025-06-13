import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';

class HealingSaintCard extends SaintProtectorCard{
  HealingSaintCard()
      : super(NameCardConstant.HEALINGSAINT, DescriptionCardConstant.HEALINGSAINT,
      PictureCardConstant.HEALINGSAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (activateEffect &&
        game.getCurrentPlayer().haveCardTypeInDeck(PlagueKnightCard)) {
      if (targets.isNotEmpty) {
        throw Exception("HealingSaint : Invalid number of target");
      } else {
        game.transferCardPlayerToBattleField(
            game.getCurrentPlayerIndex(),
            game.getCurrentPlayer().getIndexCardInDeck(PlagueKnightCard),
            game.getBattleField());
      }
    }
  }
}