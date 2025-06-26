import 'package:safran/models/card/triad/cursedKnight/conquest_knight_card.dart';

import '../../../game.dart';
import '../../../logger.dart';
import '../../constant/description_card_constant.dart';
import '../../constant/name_card_constant.dart';
import '../../constant/picture_card_constant.dart';
import '../../dealer.dart';
import '../../game_card.dart';
import 'fate_herald_card.dart';

class PowerHeraldCard extends FateHeraldCard{
  PowerHeraldCard()
      : super(NameCardConstant.POWERHERALD, DescriptionCardConstant.POWERHERALD,
      PictureCardConstant.POWERHERALD);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(1, targets);
      if (activateEffect &&
          game.getCurrentPlayer().haveCardTypeInDeck(ConquestKnightCard)) {
        Dealer.transferCardPlayerToPlayer(
            game.getCurrentPlayer(),
            game.getCurrentPlayer().getIndexCardInDeck(ConquestKnightCard),
            game.players[targets[0]]);
      }
    } catch (e) {
      Logger.error("Error while playing PowerHeraldCard: $e");
      rethrow;
    }
  }
}