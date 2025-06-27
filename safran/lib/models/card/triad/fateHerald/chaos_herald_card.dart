import 'package:safran/models/card/constant/card_info.dart';
import 'package:safran/models/card/dealer.dart';
import 'package:safran/models/card/triad/cursedKnight/war_knight_card.dart';

import '../../../game.dart';
import '../../../logger.dart';
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
