import 'package:safran/models/card/recruitment/recruitment_card.dart';

import '../../../game.dart';

abstract class MageCard extends RecruitmentCard {
  MageCard(super.name, super.description, super.image);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}