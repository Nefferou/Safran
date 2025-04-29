import 'package:safran/models/card/triad/cursedKnight/famineKnightCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class AbundanceSaintCard extends SaintProtectorCard{
  AbundanceSaintCard()
      : super(NameCardConstant.ABUNDANCESAINT, DescriptionCardConstant.ABUNDANCESAINT,
      PictureCardConstant.ABUNDANCESAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (activateEffect &&
        game.getCurrentPlayer().haveCardTypeInDeck(FamineKnightCard)) {
      if (targets.isEmpty) {
        throw Exception("AbundanceSaint : Invalid number of target");
      } else {
        game.transferCardPlayerToBattleField(
            game.getCurrentPlayerIndex(),
            game.getCurrentPlayer().getIndexCardInDeck(FamineKnightCard),
            game.getBattleField());
      }
    }
  }
}