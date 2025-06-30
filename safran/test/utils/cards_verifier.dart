import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/battle_field.dart';
import 'package:safran/entities/player.dart';

class CardsVerifier {
  static verifyPlayerNbCard(Player player, int playerNbCard) {
    // Verify the number of cards in the player's deck
    expect(player.getDeckLength(), playerNbCard);
  }

  static verifyBattleFieldNbCard(BattleField battleField, int battleFieldNbCard) {
    // Verify the number of cards in the battlefield
    expect(battleField.getLength(), battleFieldNbCard);
  }

  static verifyIfCardTypeIsInDeck(Player player, Type cardType) {
    // Verify if the cards type is in the player's deck
    expect(getIndexCardByType(player, cardType), isNot(-1));
  }

  static verifyIfCardTypeIsntInDeck(Player player, Type cardType) {
    // Verify if the cards type is in the player's deck
    expect(getIndexCardByType(player, cardType), -1);
  }

  static getIndexCardByType(Player player, Type cardType) {
    int indexCard =
    player.deck.indexWhere((card) => card.runtimeType == cardType);
    return indexCard;
  }
}