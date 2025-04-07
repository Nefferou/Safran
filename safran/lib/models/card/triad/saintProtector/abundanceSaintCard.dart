import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class AbundanceSaintCard extends SaintProtectorCard{
  AbundanceSaintCard()
      : super(NameCardConstant.ABUNDANCESAINT, DescriptionCardConstant.ABUNDANCESAINT,
      PictureCardConstant.ABUNDANCESAINT);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}