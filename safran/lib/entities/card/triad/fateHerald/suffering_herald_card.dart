import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/entities/card/triad/cursedKnight/famine_knight_card.dart';

import '../../../../entities/game.dart';
import '../../../../services/logger.dart';
import '../../../../services/dealer.dart';
import '../../game_card.dart';
import 'fate_herald_card.dart';

class SufferingHeraldCard extends FateHeraldCard{
  SufferingHeraldCard()
      : super(CardInfo.sufferingHerald);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(FamineKnightCard)) {
        Dealer.transferCardPlayerToPlayer(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(FamineKnightCard),
            game.players[targets[0]]);
      }
    } catch (e) {
      Logger.error("Error while playing SufferingHeraldCard: $e");
      rethrow;
    }
  }
}