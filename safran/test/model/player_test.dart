import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/card/recruitment/army/guard_card.dart';
import 'package:safran/entities/card/recruitment/thief_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/plague_knight_card.dart';
import 'package:safran/entities/card/triad/fateHerald/disease_herald_card.dart';
import 'package:safran/entities/card/triad/saintProtector/abundance_saint_card.dart';
import 'package:safran/entities/game.dart';

import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
  });

  group("Player", () {
    test("Card Not in Deck", () {
      expect(customGame.players[0].getIndexCardInDeck(AbundanceSaintCard), -1);
    });

    test("Choose and Play Card", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);

      customGame.players[0].readPlayerLine = () => 1;

      customGame.players[0].play(customGame);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
    });

    test("Choose and Play Card Cant Be Played", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], PlagueKnightCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);

      final inputs = [10, 1];
      customGame.players[0].readPlayerLine = () => inputs.removeAt(0);

      customGame.players[0].play(customGame);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], PlagueKnightCard);
    });

    test("Play Card With Taget", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], DiseaseHeraldCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], PlagueKnightCard);

      customGame.players[0].readPlayerLine = () => 1;

      customGame.players[0].playCard(customGame, 8);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], DiseaseHeraldCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], PlagueKnightCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], PlagueKnightCard);
    });

    test("Play Card With Two Taget", () {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[2], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], ThiefCard);

      final inputs = [1, 2];
      customGame.players[0].readPlayerLine = () => inputs.removeAt(0);

      customGame.players[0].playCard(customGame, 7);

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
      CardsVerifier.verifyPlayerNbCard(customGame.players[2], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], ThiefCard);
    });
  });
}