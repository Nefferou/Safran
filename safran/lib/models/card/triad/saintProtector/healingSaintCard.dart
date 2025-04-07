import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';

import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';

class HealingSaintCard extends SaintProtectorCard{
  HealingSaintCard()
      : super(NameCardConstant.HEALINGSAINT, DescriptionCardConstant.HEALINGSAINT,
      PictureCardConstant.HEALINGSAINT);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}