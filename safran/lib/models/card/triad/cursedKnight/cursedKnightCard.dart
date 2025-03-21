import '../triadCard.dart';

abstract class CursedKnightCard extends TriadCard {
  bool isPlayed;

  CursedKnightCard(super.name, super.description, super.image, super.game)
      : isPlayed = false;

  canBePlayed() {
    ///TODO
  }
}