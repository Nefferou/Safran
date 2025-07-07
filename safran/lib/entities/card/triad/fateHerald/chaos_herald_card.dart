import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/services/dealer.dart';
import 'package:safran/entities/card/triad/cursedKnight/war_knight_card.dart';

import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../game_card.dart';
import 'fate_herald_card.dart';

class ChaosHeraldCard extends FateHeraldCard {
  ChaosHeraldCard()
      : super(CardInfo.chaosHerald);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(WarKnightCard)) {
        Dealer.transferCardPlayerToPlayer(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(WarKnightCard),
            game.players[targets[0]]);
      }
    } catch (e) {
      Logger.error("Error while playing ChaosHeraldCard: $e");
      rethrow;
    }
  }
}
