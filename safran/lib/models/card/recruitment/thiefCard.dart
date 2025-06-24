import 'package:safran/models/card/constant/descriptionCardConstant.dart';
import 'package:safran/models/card/constant/nameCardConstant.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/dealer.dart';
import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';

import '../../game.dart';
import '../../logger.dart';
import '../triad/cursedKnight/plagueKnightCard.dart';

class ThiefCard extends RecruitmentCard {
  ThiefCard()
      : super(NameCardConstant.THIEF, DescriptionCardConstant.THIEF,
            PictureCardConstant.THIEF);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    try {
      GameCard.correctNbTargets(2, targets);
      Type typeSteal = Dealer.transferCardPlayerToPlayer(game.players[targets[1]], -1, game.players[targets[0]]);
      Logger.info("Player ${game.players[targets[0]].userName} steals a card from player ${game.players[targets[1]].userName}");

      if(typeSteal == PlagueKnightCard) {
        game.kill(game.players[targets[1]]);
      }
    } catch (e) {
      Logger.error("Error while playing ThiefCard: $e");
      rethrow;
    }
  }
}
