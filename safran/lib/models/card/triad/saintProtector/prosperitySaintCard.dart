import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class ProsperitySaintCard extends SaintProtectorCard{
  ProsperitySaintCard(game)
      : super(NameCardConstant.PROSPERITYSAINT, DescriptionCardConstant.PROSPERITYSAINT,
      PictureCardConstant.PROSPERITYSAINT, game);

  play() {
    ///TODO
  }
}