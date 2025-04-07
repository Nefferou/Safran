import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'cursedKnightCard.dart';

class FamineKnightCard extends CursedKnightCard {
  FamineKnightCard()
      : super(NameCardConstant.FAMINEKNIGHT, DescriptionCardConstant.FAMINEKNIGHT,
      PictureCardConstant.FAMINEKNIGHT);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}