import 'dart:io';
import 'dart:math';

import 'package:safran/core/constants/player_status_constant.dart';
import 'package:safran/services/dealer.dart';
import 'package:safran/entities/card/recruitment/mage/mage_card.dart';
import 'package:safran/entities/card/recruitment/thief_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/conquest_knight_card.dart';
import 'package:safran/entities/card/triad/fateHerald/fate_herald_card.dart';
import 'package:safran/services/logger.dart';

import '../entities/card/game_card.dart';
import '../entities/card/triad/cursedKnight/cursed_knight_card.dart';
import '../entities/card/triad/cursedKnight/famine_knight_card.dart';
import 'game.dart';

class Player {
  late int Function() readPlayerLine = _defaultReadPlayerLine;

  String userName;
  bool isTheirTurn;
  bool isInPause = false;
  String status;
  int timeInPause = 0;

  List<GameCard> deck = [];

  Player(this.userName)
      : status = PlayerStatusConstant.alive,
        isTheirTurn = false;

  playCard(Game game, indexCard) {
    // Check if card require one target
    if (getCard(indexCard) is MageCard || getCard(indexCard) is FateHeraldCard) {
      stdout.write("Choose target : ");
      int target = readPlayerLine();
      playCardWithOneTarget(game, indexCard, target);
    }
    // Check if card require two target
    else if (getCard(indexCard) is ThiefCard) {
      stdout.write("Choose stealer target : ");
      int stealerTarget = readPlayerLine();
      stdout.write("Choose stolen target : ");
      int stolenTarget = readPlayerLine();
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

    // Discard the card played
    Dealer.transferCardPlayerToBattleField(
        game.getCurrentPlayer(), indexCard, game.battleField);
  }

  playCardWithOneTarget(Game game, indexCard, int target) {
    Logger.info("$userName play ${getCard(indexCard).name}");

    // Play the card with one target player
    Logger.info("${game.players[target].userName} is the target");
    getCard(indexCard).play(game, [target]);

    // Discard the card played
    Dealer.transferCardPlayerToBattleField(
        game.getCurrentPlayer(), indexCard, game.battleField);
  }

  playCardWithTwoTargets(Game game, indexCard, int target1, int target2) {
    Logger.info("$userName play ${getCard(indexCard).name}");

    // Player chooses two target players
    Logger.info("${game.players[target1].userName} draw a card from ${game.players[target2].userName}");
    getCard(indexCard).play(game, [target1, target2]);

    // Discard the card played
    Dealer.transferCardPlayerToBattleField(
        game.getCurrentPlayer(), indexCard, game.battleField);
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

  discardCard(Game game, [int indexCard = -1]) {
    Logger.info("$userName discard a card");

    game.handleCardCanBePlayed(this);
    Dealer.transferCardPlayerToBattleField(
        this, indexCard, game.battleField);
  }
  
  discardAllCard(Game game) {
    while (deck.isNotEmpty) {
      Dealer.transferCardPlayerToBattleField(
          this, 0, game.battleField);
    }
  }

  getCard(int indexCard) {
    return deck[indexCard];
  }

  getDeckLength() {
    return deck.length;
  }

  pausePlayer() {
    isInPause = !isInPause;
    Logger.info("$userName in paused");
  }

  play(Game game) {
    // Player chooses a card to play
    stdout.write("Entrez l'index de la carte à jouer : ");
    int indexCard = readPlayerLine();

    while (!deck[indexCard].canBePlayed(this)) {
      stdout.write("Choisir un autre index de carte à jouer : ");
      indexCard = readPlayerLine();
    }

    // Player plays the card
    Logger.info("$userName play ${deck[indexCard].name}");
    playCard(game, indexCard);
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

  haveConquestKnightCard() {
    return haveCardTypeInDeck(ConquestKnightCard);
  }

  haveOnlyKnightCardTypeInDeck() {
    return deck.every((card) => card is CursedKnightCard);
  }

  static int _defaultReadPlayerLine() {
    final line = (stdin.readLineSync)();
    return int.parse(line!);
  }
}
