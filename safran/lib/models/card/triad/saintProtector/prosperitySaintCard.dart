import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class ProsperitySaintCard extends SaintProtectorCard{
  ProsperitySaintCard()
      : super(NameCardConstant.PROSPERITYSAINT, DescriptionCardConstant.PROSPERITYSAINT,
      PictureCardConstant.PROSPERITYSAINT);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}