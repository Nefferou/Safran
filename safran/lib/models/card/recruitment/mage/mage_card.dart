import 'package:safran/models/card/recruitment/recruitment_card.dart';

import '../../../game.dart';

abstract class MageCard extends RecruitmentCard {
  MageCard(super.cardInfo);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}