import 'package:safran/models/game.dart';
import 'package:safran/models/player.dart';

class FakePlayer extends Player {
  FakePlayer(super.name);

  @override
  void play(Game game) {
    playCardWithoutTarget(game, 0);
  }
}