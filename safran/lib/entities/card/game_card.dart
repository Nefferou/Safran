import 'package:safran/entities/game.dart';

abstract class GameCard {

  final String name;
  final String description;
  final String image;

  GameCard(this.name, this.description, this.image);

  canBePlayed(Game game) {
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