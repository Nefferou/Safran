import 'package:safran/models/card/card.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';

import '../../../game.dart';
import '../../../player.dart';

abstract class MageCard extends RecruitmentCard{
  MageCard(super.name, super.description, super.image);

  play(Game game, [List<int> targets = const []]);
}