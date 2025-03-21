import 'package:safran/models/card/cardFactory.dart';
import 'package:safran/models/game.dart';
import 'package:safran/models/player.dart';

class GameIT {

  late Game game;

  late Player player1;
  late Player player2;
  late Player player3;
  late Player player4;
  late Player player5;
  late Player player6;

  late CardFactory cardFactory;

  setUp() {
    player1 = new Player("P1");
    player2 = new Player("P2");
    player3 = new Player("P3");
    player4 = new Player("P4");
    player5 = new Player("P5");
    player6 = new Player("P6");

    game = new Game([player1, player2, player3, player4, player5, player6]);
    game.setDeck(cardFactory.createDeck(3, 21, 15, 10));
  }
}