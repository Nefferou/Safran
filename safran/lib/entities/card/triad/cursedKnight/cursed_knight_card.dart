import '../../../../entities/game.dart';
import '../triad_card.dart';

abstract class CursedKnightCard extends TriadCard {
  bool isPlayed;

  CursedKnightCard(super.cardInfo)
      : isPlayed = false;

  @override
  canBePlayed(Game game) {
    return game.getCurrentPlayer().haveOnlyKnightCardTypeInDeck();
  }

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}