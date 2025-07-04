import 'package:safran/entities/game.dart';

import '../player.dart';

abstract class GameCard {

  final String name;
  final String description;
  final String image;
  bool canPlay;

  GameCard(this.name, this.description, this.image, this.canPlay);

  canBePlayed(Player player) {
    return true;
  }

  play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    // Default implementation does nothing
  }

  static correctNbTargets(int nbTargets, List<int> targets) {
    if (nbTargets != targets.length) {
      throw Exception("Invalid number of targets: $nbTargets. Expected: ${targets.length}");
    }
  }
}