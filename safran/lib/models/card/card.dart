import 'package:safran/models/game.dart';

abstract class Card {

  String name;
  String description;
  String image;

  Game game;

  Card(this.name, this.description, this.image, this.game);
}