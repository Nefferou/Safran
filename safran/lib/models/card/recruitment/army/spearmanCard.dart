import 'package:safran/models/card/recruitment/army/armyCard.dart';

import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class SpearmanCard extends ArmyCard {
  SpearmanCard(game)
      : super(NameCardConstant.SPEARMAN, DescriptionCardConstant.SPEARMAN,
      PictureCardConstant.SPEARMAN, game);

  play() {
    ///TODO
  }
}