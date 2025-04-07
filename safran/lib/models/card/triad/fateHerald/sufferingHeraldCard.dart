import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'fateHeraldCard.dart';

class SufferingHeraldCard extends FateHeraldCard{
  SufferingHeraldCard()
      : super(NameCardConstant.SUFFERINGHERALD, DescriptionCardConstant.SUFFERINGHERALD,
      PictureCardConstant.SUFFERINGHERALD);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}