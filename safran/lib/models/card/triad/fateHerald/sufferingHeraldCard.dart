import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class SufferingHeraldCard extends FateHeraldCard{
  SufferingHeraldCard(game)
      : super(NameCardConstant.SUFFERINGHERALD, DescriptionCardConstant.SUFFERINGHERALD,
      PictureCardConstant.SUFFERINGHERALD, game);

  play() {
    ///TODO
  }
}