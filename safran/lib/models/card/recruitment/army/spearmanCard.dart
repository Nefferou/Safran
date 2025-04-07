import 'package:safran/models/card/recruitment/army/armyCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class SpearmanCard extends ArmyCard {
  SpearmanCard()
      : super(NameCardConstant.SPEARMAN, DescriptionCardConstant.SPEARMAN,
      PictureCardConstant.SPEARMAN);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}