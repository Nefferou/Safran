import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:safran/core/constants/player_status_constant.dart';
import 'package:safran/entities/card/triad/saintProtector/saint_protector_card.dart';
import 'package:safran/services/dealer.dart';
import 'package:safran/entities/card/recruitment/mage/mage_card.dart';
import 'package:safran/entities/card/recruitment/thief_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/conquest_knight_card.dart';
import 'package:safran/entities/card/triad/fateHerald/fate_herald_card.dart';
import 'package:safran/services/logger.dart';

import '../entities/card/game_card.dart';
import '../entities/card/triad/cursedKnight/cursed_knight_card.dart';
import '../entities/card/triad/cursedKnight/famine_knight_card.dart';
import 'card/triad/cursedKnight/war_knight_card.dart';
import 'game.dart';

class Player extends ChangeNotifier {

  String userName;
  bool isTheirTurn;
  bool isInPause = false;
  String status;
  int timeInPause = 0;

  Completer<int>? _pendingPlay;
  Completer<int>? _pendingPlayTarget;

  List<GameCard> deck = [];

  Player(this.userName)
      : status = PlayerStatusConstant.alive,
        isTheirTurn = false;

  Future<void> playCard(Game game, indexCard) async {
    // Check if card require one target
    if (getCard(indexCard) is MageCard || getCard(indexCard) is FateHeraldCard) {
      game.setActionMessage("${userName} choisir un joueur comme cible");

      _pendingPlayTarget = Completer<int>();

      final target = await _pendingPlayTarget!.future;

      playCardWithOneTarget(game, indexCard, target);
    }
    // Check if card require two target
    else if (getCard(indexCard) is ThiefCard) {
      game.setActionMessage("${userName} choisir le voleur");

      _pendingPlayTarget = Completer<int>();

      final stealerTarget = await _pendingPlayTarget!.future;

      game.setActionMessage("${userName} choisir le volé");

      _pendingPlayTarget = Completer<int>();

      final stolenTarget = await _pendingPlayTarget!.future;

      playCardWithTwoTargets(game, indexCard, stealerTarget, stolenTarget);
    }
    // Check if card doesn't require any target
    else {
      await playCardWithoutTarget(game, indexCard);
    }
  }

  Future<void> playCardWithoutTarget(Game game, indexCard) async {
    Logger.info("$userName play ${getCard(indexCard).name}");

    GameCard choosenCard = getCard(indexCard);

    await deck[indexCard].play(game);

    if (indexCard > deck.length-1 || getCard(indexCard) != choosenCard) {
      indexCard--;
    }

    // Discard the card played
    Dealer.transferCardPlayerToBattleField(
        game.getCurrentPlayer(), indexCard, game.battleField);
  }

  playCardWithOneTarget(Game game, indexCard, int target) {
    Logger.info("$userName play ${getCard(indexCard).name}");

    GameCard choosenCard = getCard(indexCard);

    // Play the card with one target player
    Logger.info("${game.players[target].userName} is the target");
    getCard(indexCard).play(game, [target]);

    if (indexCard > deck.length-1 || getCard(indexCard) != choosenCard) {
      indexCard--;
    }

    // Discard the card played
    Dealer.transferCardPlayerToBattleField(
        game.getCurrentPlayer(), indexCard, game.battleField);
  }

  playCardWithTwoTargets(Game game, indexCard, int target1, int target2) {
    Logger.info("$userName play ${getCard(indexCard).name}");

    GameCard choosenCard = getCard(indexCard);
    Logger.info("carte choisie : ${choosenCard}");

    // Player chooses two target players
    Logger.info("${game.players[target1].userName} draw a card from ${game.players[target2].userName}");
    getCard(indexCard).play(game, [target1, target2]);

    if (indexCard > deck.length-1 || getCard(indexCard) != choosenCard) {
      indexCard--;
    }

    // Discard the card played
    if (deck.length != 0) {
      Dealer.transferCardPlayerToBattleField(
          game.getCurrentPlayer(), indexCard, game.battleField);
    }
  }

  void addCards(List<GameCard> cards) {
    deck.addAll(cards);
    notifyListeners();
  }

  takeCard(int indexCard) {
    GameCard card = deck.elementAt(indexCard);
    deck.removeAt(indexCard);
    notifyListeners();

    return card;
  }

  takeRandomCard(bool canTakeAllCard) {
    int deckLength = deck.length;
    int randomIndex = Random().nextInt(deckLength);

    GameCard card = deck.elementAt(randomIndex);

    if (!card.canPlay && !canTakeAllCard) {
      return takeRandomCard(canTakeAllCard);
    }

    deck.removeAt(randomIndex);
    notifyListeners();

    return card;
  }

  Future<void> discardCard(Game game, [int indexCard = -1, bool otherPlayerNeedToChooseCard = false, bool discardBecauseOfFamine = false]) async {
    Logger.info("$userName discard a card");

    game.battleMode = false;

    final otherPlayer = game.players.where(
          (player) => player.haveCardTypeInDeck(WarKnightCard) && player != this,
    );

    if (otherPlayer.isNotEmpty && !discardBecauseOfFamine) {
      game.setActionMessage("${otherPlayer.first.userName} defausser");

      await otherPlayer.first.discardCard(game, -1, true);

      game.setActionMessage("$userName defausser");
    }

    if (otherPlayerNeedToChooseCard) {
      _pendingPlay = Completer<int>();

      indexCard = await _pendingPlay!.future;
    }

    game.handleCardCanBePlayed(this);
    Dealer.transferCardPlayerToBattleField(
        this, indexCard, game.battleField);

    Logger.info("battlefield discard : ${game.battleField.cards}");
  }
  
  discardAllCard(Game game) {
    game.battleMode = false;

    while (deck.isNotEmpty) {
      Dealer.transferCardPlayerToBattleField(
          this, 0, game.battleField);
    }
    notifyListeners();
  }

  GameCard getCard(int indexCard) {
    return deck[indexCard];
  }

  getDeckLength() {
    return deck.length;
  }

  pausePlayer() {
    isInPause = !isInPause;
    Logger.info("$userName in paused");
  }

  Future<void> play(Game game) async {
    Logger.info("Entrez l'index de la carte à jouer : ");
    game.setActionMessage("${userName} choisir une carte à jouer");

    _pendingPlay = Completer<int>();

    final indexCard = await _pendingPlay!.future;

    if (!deck[indexCard].canBePlayed(this)) {
      Logger.info("Cette carte ne peut pas être jouée !");
      return await play(game);
    }

    // Player plays the card
    Logger.info("$userName play ${deck[indexCard].name}");
    await playCard(game, indexCard);
  }

  Future<void> handleFamineKnight(Game game) async {
    if (haveFamineKnightCard()) {
      game.setActionMessage("${userName} defausser à cause du cavalier de la famine");

      _pendingPlay = Completer<int>();

      final indexCard = await _pendingPlay!.future;

      if (!deck[indexCard].canBePlayed(this)) {
        Logger.info("Cette carte ne peut pas être jouée !");
        return await handleFamineKnight(game);
      }

      await discardCard(game, indexCard, false, true);
    }
    game.handleCardCanBePlayed(this);
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

  void chooseCard(int index) {
    if (_pendingPlay != null && !_pendingPlay!.isCompleted) {
      _pendingPlay!.complete(index);
      _pendingPlay = null;
    }
  }

  void choosePlayer(int index) {
    if (_pendingPlayTarget != null && !_pendingPlayTarget!.isCompleted) {
      _pendingPlayTarget!.complete(index);
      _pendingPlayTarget = null;
    }
  }
}
