import 'package:safran/models/card/triad/cursedKnight/warKnightCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';

class PeaceSaintCard extends SaintProtectorCard{
  PeaceSaintCard()
      : super(NameCardConstant.PEACESAINT, DescriptionCardConstant.PEACESAINT,
      PictureCardConstant.PEACESAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (activateEffect &&
        game.getCurrentPlayer().haveCardTypeInDeck(WarKnightCard)) {
      if (targets.isEmpty) {
        throw Exception("PeaceSaint : Invalid number of target");
      } else {
        game.transferCardPlayerToBattleField(
            game.getCurrentPlayerIndex(),
            game.getCurrentPlayer().getIndexCardInDeck(WarKnightCard),
            game.getBattleField());
      }
    }
  }
}