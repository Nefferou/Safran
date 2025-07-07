import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/entities/card/game_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/famine_knight_card.dart';
import 'package:safran/entities/card/triad/saintProtector/saint_protector_card.dart';

import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../../../services/dealer.dart';

class AbundanceSaintCard extends SaintProtectorCard {
  AbundanceSaintCard()
      : super(CardInfo.abundanceSaint);

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
