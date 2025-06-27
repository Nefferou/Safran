import 'package:safran/models/card/constant/card_info.dart';
import 'package:safran/models/card/triad/cursedKnight/war_knight_card.dart';
import 'package:safran/models/card/triad/saintProtector/saint_protector_card.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../dealer.dart';
import '../../game_card.dart';

class PeaceSaintCard extends SaintProtectorCard{
  PeaceSaintCard()
      : super(CardInfo.peaceSaint);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(WarKnightCard)) {
        GameCard.correctNbTargets(0, targets);
        Dealer.transferCardPlayerToBattleField(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(WarKnightCard),
            game.battleField);
      }
    } catch (e) {
      Logger.error("Error while playing PeaceSaintCard: $e");
      rethrow;
    }
  }
}