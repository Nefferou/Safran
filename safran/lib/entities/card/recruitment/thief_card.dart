import 'package:safran/core/constants/card_info_constant.dart';
import 'package:safran/services/dealer.dart';
import 'package:safran/entities/card/game_card.dart';
import 'package:safran/entities/card/recruitment/recruitment_card.dart';

import '../../../entities/game.dart';
import '../../../services/logger.dart';
import '../triad/cursedKnight/plague_knight_card.dart';

class ThiefCard extends RecruitmentCard {
  ThiefCard()
      : super(CardInfo.thief);

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
