import 'package:safran/models/card/constant/descriptionCardConstante.dart';
import 'package:safran/models/card/constant/nameCardConstante.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/army/armyCard.dart';

import '../../../game.dart';

class GardCard extends ArmyCard {
  GardCard()
      : super(NameCardConstant.GARDE, DescriptionCardConstant.GARDE,
            PictureCardConstant.GARDE);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}
