import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class DiseaseHeraldCard extends FateHeraldCard{
  DiseaseHeraldCard()
      : super(NameCardConstant.DISEASEHERALD, DescriptionCardConstant.DISEASEHERALD,
      PictureCardConstant.DISEASEHERALD);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}