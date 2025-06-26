import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/triad/cursedKnight/famine_knight_card.dart';
import 'package:safran/models/card/triad/saintProtector/saint_protector_card.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/description_card_constant.dart';
import '../../constant/name_card_constant.dart';
import '../../constant/picture_card_constant.dart';
import '../../dealer.dart';

class AbundanceSaintCard extends SaintProtectorCard {
  AbundanceSaintCard()
      : super(
            NameCardConstant.ABUNDANCESAINT,
            DescriptionCardConstant.ABUNDANCESAINT,
            PictureCardConstant.ABUNDANCESAINT);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(FamineKnightCard)) {
        GameCard.correctNbTargets(0, targets);
        Dealer.transferCardPlayerToBattleField(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(FamineKnightCard),
            game.battleField);
      }
    } catch (e) {
      Logger.error("Error while playing AbundanceSaintCard: $e");
      rethrow;
    }
  }
}
