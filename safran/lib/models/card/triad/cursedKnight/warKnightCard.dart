import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'cursedKnightCard.dart';

class WarKnightCard extends CursedKnightCard {
  WarKnightCard()
      : super(NameCardConstant.WARKNIGHT, DescriptionCardConstant.WARKNIGHT,
      PictureCardConstant.WARKNIGHT);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}