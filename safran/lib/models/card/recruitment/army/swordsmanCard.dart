import 'package:safran/models/card/recruitment/army/armyCard.dart';

import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class SwordsmanCard extends ArmyCard {
  SwordsmanCard(game)
      : super(NameCardConstant.SWORSDMAN, DescriptionCardConstant.SWORSDMAN,
      PictureCardConstant.SWORSDMAN, game);

  play() {
    ///TODO
  }
}