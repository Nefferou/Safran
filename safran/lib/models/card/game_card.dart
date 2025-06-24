import 'package:safran/models/game.dart';

abstract class GameCard {

  final String name;
  final String description;
  final String image;

  GameCard(this.name, this.description, this.image);

  @override
  String toString() {
    return "[$name]";
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