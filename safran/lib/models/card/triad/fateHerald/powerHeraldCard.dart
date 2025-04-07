import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class PowerHeraldCard extends FateHeraldCard{
  PowerHeraldCard()
      : super(NameCardConstant.POWERHERALD, DescriptionCardConstant.POWERHERALD,
      PictureCardConstant.POWERHERALD);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}