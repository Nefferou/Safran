import 'package:safran/models/card/constant/descriptionCardConstante.dart';
import 'package:safran/models/card/constant/nameCardConstante.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';

class CommanderCard extends RecruitmentCard {
  CommanderCard(game)
      : super(NameCardConstant.COMMANDER, DescriptionCardConstant.COMMANDER,
            PictureCardConstant.COMMANDER, game);

  play() {
    game.battleField.shuffleBattleField();
    game.changePlayOrder();
  }
}
