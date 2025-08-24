import 'package:safran/entities/game.dart';
import 'package:safran/entities/player.dart';

class FakePlayer extends Player {
  FakePlayer(super.name);

  @override
  Future<void> play(Game game, [String? Function()? readLine, String? Function()? readLine2]) async {
    playCardWithoutTarget(game, 0);
  }
}