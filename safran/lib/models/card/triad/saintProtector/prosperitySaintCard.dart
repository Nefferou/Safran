import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';

class ProsperitySaintCard extends SaintProtectorCard{
  ProsperitySaintCard()
      : super(NameCardConstant.PROSPERITYSAINT, DescriptionCardConstant.PROSPERITYSAINT,
      PictureCardConstant.PROSPERITYSAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    if (activateEffect &&
        game.getCurrentPlayer().haveCardTypeInDeck(ConquestKnightCard)) {
      if (targets.isEmpty) {
        throw Exception("ProsperitySaint : Invalid number of target");
      } else {
        game.transferCardPlayerToBattleField(
            game.getCurrentPlayerIndex(),
            game.getCurrentPlayer().getIndexCardInDeck(ConquestKnightCard),
            game.getBattleField());
      }
    }
  }
}