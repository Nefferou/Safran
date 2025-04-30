import 'package:safran/models/card/constant/descriptionCardConstant.dart';
import 'package:safran/models/card/constant/nameCardConstant.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';

import '../../game.dart';
import '../../logger.dart';

class ThiefCard extends RecruitmentCard {
  ThiefCard()
      : super(NameCardConstant.THIELF, DescriptionCardConstant.THIELF,
            PictureCardConstant.THIELF);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    Logger.info("Player ${game.players[targets[0]].userName} steals a card from player ${game.players[targets[1]].userName}");
    if(targets.length != 2) {
      throw Exception("Thief : Invalid number of target");
    } else {
      game.transferCardPlayerToPlayer(targets[1], -1, targets[0]);
    }
  }
}
