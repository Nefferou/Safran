import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/logger.dart';
import 'package:safran/models/player.dart';

class TestPlayer extends Player {
  int? indexToDiscard;
  int? indexToPlayer1;
  int? indexToPlayer2;

  TestPlayer(super.name);

  @override
  int discardCard() {
    Logger.info("$userName discard a card");

    final int index = indexToDiscard ?? 0;
    return index;
  }
}
