import '../../../game.dart';
import '../triad_card.dart';

abstract class FateHeraldCard extends TriadCard{

  FateHeraldCard(super.name, super.description, super.image);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}