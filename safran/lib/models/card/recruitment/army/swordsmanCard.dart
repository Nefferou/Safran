import 'package:safran/models/card/recruitment/army/armyCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class SwordsmanCard extends ArmyCard {
  SwordsmanCard()
      : super(NameCardConstant.SWORSDMAN, DescriptionCardConstant.SWORSDMAN,
            PictureCardConstant.SWORSDMAN);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}
