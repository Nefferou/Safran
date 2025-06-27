import '../../../game.dart';
import '../recruitment_card.dart';

abstract class ArmyCard extends RecruitmentCard {
  ArmyCard(super.cardInfo);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}