import 'package:safran/entities/game.dart';
import 'package:safran/entities/player.dart';

class FakePlayer extends Player {
  FakePlayer(super.name);

  @override
  void play(Game game, [String? Function()? readLine, String? Function()? readLine2]) {
    playCardWithoutTarget(game, 0);
  }
}