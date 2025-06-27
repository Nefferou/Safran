import '../../../game.dart';
import '../triad_card.dart';

abstract class FateHeraldCard extends TriadCard{

  FateHeraldCard(super.cardInfo);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}