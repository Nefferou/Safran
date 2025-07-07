import 'package:safran/entities/card/recruitment/recruitment_card.dart';

import '../../../../entities/game.dart';

abstract class MageCard extends RecruitmentCard {
  MageCard(super.cardInfo);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}