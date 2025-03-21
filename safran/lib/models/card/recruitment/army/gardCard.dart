import 'package:safran/models/card/constant/descriptionCardConstante.dart';
import 'package:safran/models/card/constant/nameCardConstante.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/army/armyCard.dart';

class GardCard extends ArmyCard {
  GardCard(game)
      : super(NameCardConstant.GARDE, DescriptionCardConstant.GARDE,
            PictureCardConstant.GARDE, game);

  play() {
    ///TODO
  }
}
