import '../../../game.dart';
import '../../constant/descriptionCardConstante.dart';
import '../../constant/nameCardConstante.dart';
import '../../constant/pictureCardConstant.dart';
import 'cursedKnightCard.dart';

class PlagueKnightCard extends CursedKnightCard {
  PlagueKnightCard()
      : super(NameCardConstant.PLAGUEKNIGHT, DescriptionCardConstant.PLAGUEKNIGHT,
      PictureCardConstant.PLAGUEKNIGHT);

  play(Game game, [List<int> targets = const []]) {
    ///TODO
  }
}