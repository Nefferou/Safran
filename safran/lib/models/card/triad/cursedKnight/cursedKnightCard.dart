import '../../../game.dart';
import '../triadCard.dart';

abstract class CursedKnightCard extends TriadCard {
  bool isPlayed;

  CursedKnightCard(super.name, super.description, super.image)
      : isPlayed = false;

  canBePlayed() {
    ///TODO
  }

  play(Game game, [List<int> targets = const []]);
}