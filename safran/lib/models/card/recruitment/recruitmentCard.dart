import '../../game.dart';
import '../game_card.dart';

abstract class RecruitmentCard extends GameCard {
  RecruitmentCard(super.name, super.description, super.image);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}