import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class DiseaseHeraldCard extends FateHeraldCard{
  DiseaseHeraldCard(game)
      : super(NameCardConstant.DISEASEHERALD, DescriptionCardConstant.DISEASEHERALD,
      PictureCardConstant.DISEASEHERALD, game);

  play() {
    ///TODO
  }
}