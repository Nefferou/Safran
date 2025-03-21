import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class HealingSaintCard extends SaintProtectorCard{
  HealingSaintCard(game)
      : super(NameCardConstant.HEALINGSAINT, DescriptionCardConstant.HEALINGSAINT,
      PictureCardConstant.HEALINGSAINT, game);

  play() {
    ///TODO
  }
}