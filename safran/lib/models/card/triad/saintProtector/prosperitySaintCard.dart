import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../dealer.dart';
import '../../game_card.dart';

class ProsperitySaintCard extends SaintProtectorCard{
  ProsperitySaintCard()
      : super(NameCardConstant.PROSPERITYSAINT, DescriptionCardConstant.PROSPERITYSAINT,
      PictureCardConstant.PROSPERITYSAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(ConquestKnightCard)) {
        GameCard.correctNbTargets(0, targets);
        Dealer.transferCardPlayerToBattleField(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(ConquestKnightCard),
            game.getBattleField());
      }
    } catch (e) {
      Logger.error("Error while playing ProsperitySaintCard: $e");
      rethrow;
    }
  }
}