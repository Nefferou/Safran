import '../../../game.dart';
import '../triadCard.dart';

abstract class FateHeraldCard extends TriadCard{

  FateHeraldCard(super.name, super.description, super.image);

  play(Game game, [List<int> targets = const []]);
}