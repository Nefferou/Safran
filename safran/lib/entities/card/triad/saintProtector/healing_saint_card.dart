import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/entities/card/triad/cursedKnight/plague_knight_card.dart';
import 'package:safran/entities/card/triad/saintProtector/saint_protector_card.dart';

import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../../../services/dealer.dart';
import '../../game_card.dart';

class HealingSaintCard extends SaintProtectorCard{
  HealingSaintCard()
      : super(CardInfo.healingSaint);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(PlagueKnightCard)) {
        GameCard.correctNbTargets(0, targets);
        Dealer.transferCardPlayerToBattleField(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(PlagueKnightCard),
            game.battleField);
      }
    } catch (e) {
      Logger.error("Error while playing HealingSaintCard: $e");
      rethrow;
    }
  }
}