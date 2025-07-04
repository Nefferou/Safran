import '../../../../entities/game.dart';
import '../../../player.dart';
import '../triad_card.dart';

abstract class CursedKnightCard extends TriadCard {
  bool isPlayed;

  CursedKnightCard(super.cardInfo)
      : isPlayed = false;

  @override
  canBePlayed(Player player) {
    return player.haveOnlyKnightCardTypeInDeck();
  }

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}