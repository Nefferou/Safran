import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'cursedKnightCard.dart';

class WarKnightCard extends CursedKnightCard {
  WarKnightCard(game)
      : super(NameCardConstant.WARKNIGHT, DescriptionCardConstant.WARKNIGHT,
      PictureCardConstant.WARKNIGHT, game);

  play() {
    ///TODO
  }
}