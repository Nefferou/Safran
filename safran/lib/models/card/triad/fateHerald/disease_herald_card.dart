import 'package:safran/models/card/constant/card_info.dart';
import 'package:safran/models/card/dealer.dart';
import 'package:safran/models/card/triad/cursedKnight/plague_knight_card.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../game_card.dart';
import 'fate_herald_card.dart';

class DiseaseHeraldCard extends FateHeraldCard {
  DiseaseHeraldCard()
      : super(CardInfo.diseaseHerald);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(PlagueKnightCard)) {
        Dealer.transferCardPlayerToPlayer(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(PlagueKnightCard),
            game.players[targets[0]]);
      }
    } catch (e) {
      Logger.error("Error while playing DiseaseHeraldCard: $e");
      rethrow;
    }
  }
}
