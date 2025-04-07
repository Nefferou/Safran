import 'package:safran/models/card/constant/descriptionCardConstante.dart';
import 'package:safran/models/card/constant/nameCardConstante.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';

import '../../game.dart';

class ThielfCard extends RecruitmentCard {
  ThielfCard()
      : super(NameCardConstant.THIELF, DescriptionCardConstant.THIELF,
            PictureCardConstant.THIELF);

  play(Game game, [List<int> targets = const []]) {
    game.transferCardPlayerToPlayer(targets[0], targets[1]);
  }
}
