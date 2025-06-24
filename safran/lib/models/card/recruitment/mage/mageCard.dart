import 'package:safran/models/card/recruitment/recruitmentCard.dart';

import '../../../game.dart';

abstract class MageCard extends RecruitmentCard {
  MageCard(super.name, super.description, super.image);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}