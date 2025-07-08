import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/card/triad/cursedKnight/war_knight_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/famine_knight_card.dart';
import 'package:safran/entities/game.dart';
import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;
  late Game knightGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
    knightGame = PresetUtil.presetCanPlayKnight();
  });

  group("Cursed Knight Card tests", () {
    test("Famine Knight Card", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], FamineKnightCard);

      customGame.handleFamineKnight(customGame.players[1]);

      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
    });

    test("Can play Cursed Knight", () {
      CardsVerifier.verifyIfCardTypeIsInDeck(
          knightGame.players[0], WarKnightCard);

      int indexCardWarKnight = CardsVerifier.getIndexCardByType(
          knightGame.players[0], WarKnightCard);

      expect(
          knightGame.players[0].deck[indexCardWarKnight]
              .canBePlayed(knightGame.players[0]),
          isTrue);
    });

    test("Can't play Cursed Knight", () {
      CardsVerifier.verifyIfCardTypeIsInDeck(
          knightGame.players[1], FamineKnightCard);

      knightGame.currentPlayerTurn = 1;

      int indexCardWarKnight = CardsVerifier.getIndexCardByType(
          knightGame.players[1], FamineKnightCard);

      expect(
          knightGame.players[1].deck[indexCardWarKnight]
              .canBePlayed(knightGame.players[1]),
          isFalse);
    });
  });
} 
