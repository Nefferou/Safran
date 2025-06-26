import 'package:safran/models/card/triad/cursedKnight/conquest_knight_card.dart';
import 'package:safran/models/card/triad/saintProtector/saint_protector_card.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/description_card_constant.dart';
import '../../constant/name_card_constant.dart';
import '../../constant/picture_card_constant.dart';
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
            game.battleField);
      }
    } catch (e) {
      Logger.error("Error while playing ProsperitySaintCard: $e");
      rethrow;
    }
  }
}