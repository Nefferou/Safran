import 'package:safran/models/card/constant/descriptionCardConstante.dart';
import 'package:safran/models/card/constant/nameCardConstante.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';

import '../../game.dart';

class CommanderCard extends RecruitmentCard {
  CommanderCard()
      : super(NameCardConstant.COMMANDER, DescriptionCardConstant.COMMANDER,
            PictureCardConstant.COMMANDER);

  void play(Game game, [List<int> targets = const []]) {
    game.battleField.shuffleBattleField();
    game.changePlayOrder();
  }
}
