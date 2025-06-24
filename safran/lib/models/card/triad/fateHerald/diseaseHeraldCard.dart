import 'package:safran/models/card/dealer.dart';
import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import '../../game_card.dart';
import 'fateHeraldCard.dart';

class DiseaseHeraldCard extends FateHeraldCard {
  DiseaseHeraldCard()
      : super(
            NameCardConstant.DISEASEHERALD,
            DescriptionCardConstant.DISEASEHERALD,
            PictureCardConstant.DISEASEHERALD);

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
