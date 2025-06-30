import 'package:safran/entities/game.dart';
import 'package:safran/entities/player.dart';

class FakePlayer extends Player {
  FakePlayer(super.name);

  @override
  void play(Game game) {
    playCardWithoutTarget(game, 0);
  }
}