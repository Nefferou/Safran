import '../../../game.dart';
import '../../constant/descriptionCardConstant.dart';
import '../../constant/nameCardConstant.dart';
import '../../constant/pictureCardConstant.dart';
import 'cursedKnightCard.dart';

class ConquestKnightCard extends CursedKnightCard {
  ConquestKnightCard()
      : super(NameCardConstant.CONQUESTKNIGHT, DescriptionCardConstant.CONQUESTKNIGHT,
      PictureCardConstant.CONQUESTKNIGHT);

  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    ///TODO
  }
}
