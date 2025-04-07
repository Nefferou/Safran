import '../../../game.dart';
import '../recruitmentCard.dart';

abstract class ArmyCard extends RecruitmentCard{
  ArmyCard(super.name, super.description, super.image);

  play(Game game, [List<int> targets = const []]){
    /// TODO
  }
}