import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class ChaosHeraldCard extends FateHeraldCard{
  ChaosHeraldCard()
      : super(NameCardConstant.CHAOSHERALD, DescriptionCardConstant.CHAOSHERALD,
      PictureCardConstant.CHAOSHERALD);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}