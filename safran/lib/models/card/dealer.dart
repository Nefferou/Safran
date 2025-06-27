import 'package:safran/models/card/constant/player_status-constant.dart';
import 'package:safran/models/card/triad/cursedKnight/conquest_knight_card.dart';

import '../battle_field.dart';
import '../logger.dart';
import '../player.dart';
import 'draw_position_enum.dart';
import 'game_card.dart';

class Dealer {

  // Take Card from player or battle field
  static takeCardToPlayer(Player player, int indexCard) {
    GameCard takenCard = player.takeCard(indexCard);
    return takenCard;
  }

  static takeRandomCardToPlayer(Player player) {
    GameCard takenCard = player.takeRandomCard();
    return takenCard;
  }

  static takeCardToBattleField(BattleField battleField, DrawPositionEnum drawPosition) {
    switch (drawPosition) {
      case DrawPositionEnum.top:
        return battleField.takeUpCard();
      case DrawPositionEnum.bottom:
        return battleField.takeDownCard();
      case DrawPositionEnum.both:
        return battleField.takeBothCards();
    }
  }

  // Give Card to player or battle field
  static giveCardToPlayer(Player player, List<GameCard> cards) {
    player.deck.addAll(cards);
  }

  static giveCardToBattleField(BattleField battleField, List<GameCard> cards) {
    battleField.cards.addAll(cards);
  }

  // Transfer Card from ... to ... (Take and Give)
  static transferCardPlayerToBattleField(Player player, int indexCard, BattleField battleField) {
    GameCard cards;
    if(indexCard == -1) {
      cards = takeRandomCardToPlayer(player);
    } else {
      cards = takeCardToPlayer(player, indexCard);
    }
    if (cards is ConquestKnightCard) {
      player.status = PlayerStatusConstant.conquest;
    }
    giveCardToBattleField(battleField, [cards]);
    Logger.info("Player ${player.userName} discard");
  }

  static Type transferCardPlayerToPlayer(Player player1, int indexCard, Player player2,
      {bool canBeKill = true}) {
    GameCard cards;
    if(indexCard == -1) {
      cards = takeRandomCardToPlayer(player1);
    } else {
      cards = takeCardToPlayer(player1, indexCard);
    }

    giveCardToPlayer(player2, [cards]);
    Logger.info("Player ${player2.userName} from player ${player1.userName}");

    return cards.runtimeType;
  }

  static transferCardBattleFieldToPlayer(BattleField battleField, Player player, DrawPositionEnum drawPosition) {
    List<GameCard> cards = takeCardToBattleField(battleField, drawPosition);
    giveCardToPlayer(player, cards);
    Logger.info("Player ${player.userName} draw ${cards.length} card(s)");
  }
}