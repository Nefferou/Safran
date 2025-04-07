import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class PeaceSaintCard extends SaintProtectorCard{
  PeaceSaintCard()
      : super(NameCardConstant.PEACESAINT, DescriptionCardConstant.PEACESAINT,
      PictureCardConstant.PEACESAINT);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}