import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/entities/card/triad/cursedKnight/war_knight_card.dart';
import 'package:safran/entities/card/triad/saintProtector/saint_protector_card.dart';

import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../../../services/dealer.dart';
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