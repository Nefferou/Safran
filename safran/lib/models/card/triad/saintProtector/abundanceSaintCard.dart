import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class AbundanceSaintCard extends SaintProtectorCard{
  AbundanceSaintCard(game)
      : super(NameCardConstant.ABUNDANCESAINT, DescriptionCardConstant.ABUNDANCESAINT,
      PictureCardConstant.ABUNDANCESAINT, game);

  play() {
    ///TODO
  }
}