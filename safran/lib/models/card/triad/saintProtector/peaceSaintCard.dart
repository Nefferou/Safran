import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class PeaceSaintCard extends SaintProtectorCard{
  PeaceSaintCard(game)
      : super(NameCardConstant.PEACESAINT, DescriptionCardConstant.PEACESAINT,
      PictureCardConstant.PEACESAINT, game);

  play() {
    ///TODO
  }
}