import 'package:safran/models/game.dart';

abstract class GameCard {

  String name;
  String description;
  String image;

  GameCard(this.name, this.description, this.image);

  getName() {
    return name;
  }

  getDescription() {
    return description;
  }

  @override
  String toString() {
    return "[$name]";
  }

  play(Game game, [List<int> targets = const []]);
}