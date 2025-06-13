import 'dart:io';
import 'dart:math';

import 'package:safran/models/card/recruitment/mage/mageCard.dart';
import 'package:safran/models/card/recruitment/thiefCard.dart';
import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/warKnightCard.dart';
import 'package:safran/models/card/triad/fateHerald/fateHeraldCard.dart';
import 'package:safran/models/logger.dart';

import 'card/game_card.dart';
import 'card/triad/cursedKnight/cursedKnightCard.dart';
import 'card/triad/cursedKnight/famineKnightCard.dart';
import 'game.dart';

class Player {
  String userName;
  bool isAlive;
  bool isTheirTurn;

  List<GameCard> deck = [];

  Player(this.userName)
      : isAlive = true,
        isTheirTurn = false;

  playCard(Game game, indexCard) {
    // Check if card require one target
    if (getCard(indexCard) is MageCard || getCard(indexCard) is FateHeraldCard) {
      stdout.write("Choose target : ");
      int target = stdin.readLineSync() as int;
      playCardWithOneTarget(game, indexCard, target);
    }
    // Check if card require two target
    else if (getCard(indexCard) is ThiefCard) {
      stdout.write("Choose stealer target : ");
      int stealerTarget = stdin.readLineSync() as int;
      stdout.write("Choose stolen target : ");
      int stolenTarget = stdin.readLineSync() as int;
      playCardWithTwoTargets(game, indexCard, stealerTarget, stolenTarget);
    }
    // Check if card doesn't require any target
    else {
      playCardWithoutTarget(game, indexCard);
    }
  }

  playCardWithoutTarget(Game game, indexCard) {
    Logger.info("$userName play ${getCard(indexCard).name}");

    deck[indexCard].play(game);

    game.transferCardPlayerToBattleField(
        game.getCurrentPlayerIndex(), indexCard, game.battleField);
  }

  playCardWithOneTarget(Game game, indexCard, int target) {
    Logger.info("$userName play ${getCard(indexCard).name}");

    // Play the card with one target player
    Logger.info("${game.players[target].userName} is the target");
    getCard(indexCard).play(game, [target]);

    game.transferCardPlayerToBattleField(
        game.getCurrentPlayerIndex(), indexCard, game.battleField);
  }

  playCardWithTwoTargets(Game game, indexCard, int target1, int target2) {
    Logger.info("$userName play ${getCard(indexCard).name}");

    // Player chooses two target players
    Logger.info("${game.getPlayer(target1).userName} draw a card from ${game.getPlayer(target2).userName}");
    getCard(indexCard).play(game, [target1, target2]);

    game.transferCardPlayerToBattleField(
        game.getCurrentPlayerIndex(), indexCard, game.battleField);
  }

  kill(Game game) {
    isAlive = false;
    int playerIndex = game.getPlayerIndexWithConquestKnight();
    if (playerIndex != -1) {
      game.players[playerIndex].discardAllCard(game, playerIndex);
      Logger.info("${game.players[playerIndex].userName} have been taken by the knight of conquest");
    }
  }

  takeCard(int indexCard, Game game) {
    int deckLength = deck.length;

    if (deckLength == 1) {
      kill(game);
    }

    GameCard card = deck.elementAt(indexCard);
    deck.removeAt(indexCard);

    return card;
  }

  takeRandomCard(Game game) {
    int deckLength = deck.length;
    int randomIndex = Random().nextInt(deckLength);

    if (deckLength == 1) {
      kill(game);
    }

    GameCard card = deck.elementAt(randomIndex);
    deck.removeAt(randomIndex);

    return card;
  }

  discardCard(Game game) {
    Logger.info("$userName discard a card");

    if(game.testingMode) { /// TODO A enlevé
      return 0;
    } else {
      Player? player = game.getPlayerWithWarKnight();
      if (player != null && player != this) {
        player.discardCard(game);
      }

      // Player chooses a card to discard
      stdout.write("Entrez l'index de la carte à défausser : ");
      int indexCard = stdin.readLineSync() as int;

      return indexCard;
    }
  }
  
  discardAllCard(Game game, int playerIndex) {
    if (game.allPlayerAlive() && game.players[playerIndex].haveConquestKnightCard()) {
      game.conquestWin(playerIndex);
    }
    else {
      while (deck.isNotEmpty) {
        game.transferCardPlayerToBattleField(playerIndex, 0, game.battleField);
      }
    }
  }

  getName() {
    return userName;
  }

  getCard(int indexCard) {
    return deck[indexCard];
  }

  getDeck() {
    return deck;
  }

  getDeckLength() {
    return deck.length;
  }

  takeTurn(Game game) {
    // Check if the player is alive
    if (!isAlive) {
      return;
    }

    isTheirTurn = true;
    Logger.info("$userName turns");

    // Check if have famine knight
    if(haveFamineKnightCard()) {
      //Choose card to discard
      stdout.write("Vous avez faim");
      game.transferCardPlayerToBattleField(game.currentPlayerTurn, this.discardCard(game), game.battleField);
    }

    // Player chooses a card to play
    stdout.write("Entrez l'index de la carte à jouer : ");
    int indexCard = stdin.readLineSync() as int;

    // Player plays the card
    Logger.info("$userName play ${deck[indexCard].name}");
    playCard(game, indexCard);

    game.transferCardPlayerToBattleField(
        game.currentPlayerTurn, indexCard, game.battleField);

    // Check if player is still alive
    if (deck.isEmpty) {
      kill(game);
      Logger.info("$userName has no more cards, he is dead");
    }

    isTheirTurn = false;
  }

  haveCardTypeInDeck(Type type) {
    return deck.any((card) => card.runtimeType == type);
  }

  getIndexCardInDeck(Type type) {
    for (int i = 0; i < deck.length; i++) {
      if (deck[i].runtimeType == type) {
        return i;
      }
    }
    return -1;
  }

  haveFamineKnightCard() {
    return haveCardTypeInDeck(FamineKnightCard);
  }

  haveWarKnightCard() {
    return haveCardTypeInDeck(WarKnightCard);
  }

  haveConquestKnightCard() {
    return haveCardTypeInDeck(ConquestKnightCard);
  }

  haveOnlyKnightCardTypeInDeck() {
    return deck.every((card) => card.runtimeType == CursedKnightCard);
  }
}
