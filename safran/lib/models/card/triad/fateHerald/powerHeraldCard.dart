import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class PowerHeraldCard extends FateHeraldCard{
  PowerHeraldCard(game)
      : super(NameCardConstant.POWERHERALD, DescriptionCardConstant.POWERHERALD,
      PictureCardConstant.POWERHERALD, game);

  play() {
    ///TODO
  }
}