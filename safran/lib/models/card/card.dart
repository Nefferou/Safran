import 'package:safran/models/game.dart';

abstract class Card {

  String name;
  String description;
  String image;

  Card(this.name, this.description, this.image);

  getName() {
    return name;
  }

  getDescription() {
    return description;
  }

  @override
  String toString() {
    return "[" + name + "]";
  }

  play(Game game, [List<int> targets = const []]);
}