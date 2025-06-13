import 'package:safran/models/card/constant/descriptionCardConstant.dart';
import 'package:safran/models/card/constant/nameCardConstant.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';

import '../../game.dart';

class CommanderCard extends RecruitmentCard {
  CommanderCard()
      : super(NameCardConstant.COMMANDER, DescriptionCardConstant.COMMANDER,
            PictureCardConstant.COMMANDER);

  @override
  void play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    game.battleField.shuffleBattleField();
    game.changePlayOrder();
  }
}
