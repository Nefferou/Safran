import 'package:safran/models/card/constant/description_card_constant.dart';
import 'package:safran/models/card/constant/name_card_constant.dart';
import 'package:safran/models/card/constant/picture_card_constant.dart';
import 'package:safran/models/card/recruitment/recruitment_card.dart';

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
