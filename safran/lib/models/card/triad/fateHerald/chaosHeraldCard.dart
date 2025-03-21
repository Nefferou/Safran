import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class ChaosHeraldCard extends FateHeraldCard{
  ChaosHeraldCard(game)
      : super(NameCardConstant.CHAOSHERALD, DescriptionCardConstant.CHAOSHERALD,
      PictureCardConstant.CHAOSHERALD, game);

  play() {
    ///TODO
  }
}