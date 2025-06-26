import '../../../game.dart';
import '../triadCard.dart';

abstract class CursedKnightCard extends TriadCard {
  bool isPlayed;

  CursedKnightCard(super.name, super.description, super.image)
      : isPlayed = false;

  @override
  canBePlayed(Game game) {
    return game.getCurrentPlayer().haveOnlyKnightCardTypeInDeck();
  }

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}