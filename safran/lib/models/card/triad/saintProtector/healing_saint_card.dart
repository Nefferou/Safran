import 'package:safran/models/card/constant/card_info.dart';
import 'package:safran/models/card/triad/cursedKnight/plague_knight_card.dart';
import 'package:safran/models/card/triad/saintProtector/saint_protector_card.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../dealer.dart';
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