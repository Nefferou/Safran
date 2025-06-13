import 'package:safran/models/game.dart';

abstract class GameCard {

  String name;
  String description;
  String image;

  Game game;

  GameCard(this.name, this.description, this.image, this.game);

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
}