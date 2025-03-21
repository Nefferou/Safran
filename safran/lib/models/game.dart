import 'package:safran/models/battleField.dart';
import 'package:safran/models/player.dart';

import 'card/card.dart';


class Game {
  late bool playOrder;
  late bool battleMode;
  late BattleField battleField;

  // List of players 3-6
  List<Player> players = [];

  // List of cards
  List<Card> deck = [];

  // Constructor
  Game(this.players) {
    if(players.length < 3 || players.length > 6) {
      throw new Exception("Invalid number of players");
    } else {
      playOrder = true;
      battleMode = false;
      battleField = new BattleField();
    }
  }

  setDeck(List<Card> deck) {
    this.deck = deck;
  }

  addPlayer(Player player) {
    players.add(player);
  }

  takeTurn(Player player) {
    // Do something
  }

  takeCard(Player player) {
    // Do something
  }

  giveCard(Player player) {
    // Do something
  }

  getPlayers() {
    return players;
  }

  getBattleField() {
    return battleField;
  }

  getPlayOrder() {
    return playOrder;
  }

  getBattleMode() {
    return battleMode;
  }

  setPlayOrder(bool order) {
    playOrder = order;
  }

  setBattleMode(bool mode) {
    battleMode = mode;
  }

  setBattleField(BattleField field) {
    battleField = field;
  }

  setPlayers(List<Player> players) {
    this.players = players;
  }
}
