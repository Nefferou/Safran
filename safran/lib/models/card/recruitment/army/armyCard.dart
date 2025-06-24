import '../../../game.dart';
import '../recruitmentCard.dart';

abstract class ArmyCard extends RecruitmentCard {
  ArmyCard(super.name, super.description, super.image);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}