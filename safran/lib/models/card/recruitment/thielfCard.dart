import 'package:safran/models/card/constant/descriptionCardConstante.dart';
import 'package:safran/models/card/constant/nameCardConstante.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';
import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';

import '../../game.dart';
import '../../logger.dart';

class ThielfCard extends RecruitmentCard {
  ThielfCard()
      : super(NameCardConstant.THIELF, DescriptionCardConstant.THIELF,
            PictureCardConstant.THIELF);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    Logger.info("Player ${game.players[targets[0]].userName} steals a card from player ${game.players[targets[1]].userName}");
    if(targets.length != 2) {
      throw Exception("Thielf : Invalid number of target");
    } else {
      game.transferCardPlayerToPlayer(targets[1], -1, targets[0]);
    }
  }
}
