import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'cursedKnightCard.dart';

class ConquestKnightCard extends CursedKnightCard {
  ConquestKnightCard()
      : super(NameCardConstant.CONQUESTKNIGHT, DescriptionCardConstant.CONQUESTKNIGHT,
      PictureCardConstant.CONQUESTKNIGHT);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}
