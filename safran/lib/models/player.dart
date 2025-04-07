import 'dart:io';
import 'dart:math';

import 'package:safran/models/card/recruitment/mage/mageCard.dart';
import 'package:safran/models/card/recruitment/thielfCard.dart';
import 'package:safran/models/card/triad/fateHerald/fateHeraldCard.dart';
import 'package:safran/models/logger.dart';

import 'card/game_card.dart';
import 'game.dart';


class Player {

  String userName;
  bool isAlive;
  bool isTheirTurn;

  List<GameCard> deck = [];

  Player(this.userName)
      : isAlive = true,
        isTheirTurn = false;

  playCard(Game game, indexCard, [List<int> targets = const []]) {
    Logger.info("$userName play ${deck[indexCard].name}");
    // Check if card require one target
    if(deck[indexCard] is MageCard || deck[indexCard] is FateHeraldCard) {
      int indexPlayer;
      if(game.testingMode) {
        indexPlayer = targets[0];
      } else {
        // Player chooses a target player
        stdout.write("Choose target : ");
        indexPlayer = stdin.readLineSync() as int;
      }

      // Play the card with one target player
      Logger.info("${game.players[indexPlayer].userName} is the target");
      deck[indexCard].play(game, [indexPlayer]);
    }
    // Check if card require two target
    else if(deck[indexCard] is ThielfCard) {
      int indexPlayer1;
      int indexPlayer2;

      if(game.testingMode) {
        indexPlayer1 = targets[0];
        indexPlayer2 = targets[1];
      }
      else {
        // Player chooses two target players
        stdout.write("Choose stealer target : ");
        indexPlayer1 = stdin.readLineSync() as int;
        stdout.write("Choose stolen target : ");
        indexPlayer2 = stdin.readLineSync() as int;
      }

      Logger.info("${game.players[indexPlayer1].userName} is first target and ${game.players[indexPlayer2].userName} is second target");
      deck[indexCard].play(game, [indexPlayer1, indexPlayer2]);
    }
    // Check if card doesn't require any target
    else {
      deck[indexCard].play(game);
    }

    game.transferCardPlayerToBattleField(game.currentPlayerTurn, indexCard, game.battleField);
  }

  kill() {
    isAlive = false;
  }

  takeCard(int indexCard) {
    GameCard card = deck.elementAt(indexCard);
    deck.removeAt(indexCard);

    return card;
  }

  takeRandomCard() {
    int deckLength = deck.length;
    int randomIndex = Random().nextInt(deckLength);

    GameCard card = deck.elementAt(randomIndex);
    deck.removeAt(randomIndex);

    return card;
  }

  discardCard() {
    Logger.info("$userName discard a card");

    // Player chooses a card to play
    stdout.write("Entrez l'index de la carte à jouer : ");
    int indexCard = stdin.readLineSync() as int;

    return indexCard;
  }

  getName() {
    return userName;
  }

  getDeck() {
    return deck;
  }

  getDeckLength() {
    return deck.length;
  }

  takeTurn(Game game) {
    // Check if the player is alive
    if(!isAlive) {
      return;
    }

    isTheirTurn = true;
    Logger.info("$userName turns");

    // Player chooses a card to play
    stdout.write("Entrez l'index de la carte à jouer : ");
    int indexCard = stdin.readLineSync() as int;

    // Player plays the card
    Logger.info("$userName play ${deck[indexCard].name}");
    playCard(game, indexCard);

    game.transferCardPlayerToBattleField(game.currentPlayerTurn, indexCard, game.battleField);

    // Check if player is still alive
    if(deck.isEmpty) {
      kill();
      Logger.info("$userName has no more cards, he is dead");
    }

    isTheirTurn = false;
  }
}