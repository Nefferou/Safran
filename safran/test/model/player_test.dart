import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/card/recruitment/army/guard_card.dart';
import 'package:safran/entities/card/recruitment/thief_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/plague_knight_card.dart';
import 'package:safran/entities/card/triad/fateHerald/disease_herald_card.dart';
import 'package:safran/entities/card/triad/saintProtector/abundance_saint_card.dart';
import 'package:safran/entities/game.dart';
import 'package:safran/services/logger.dart';

import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game customGame;

  setUp(() {
    customGame = PresetUtil.presetGameWithPlayersEqualyDealed();
  });

  group("Player tests", () {
    test("Card Not in Deck", () {
      expect(customGame.players[0].getIndexCardInDeck(AbundanceSaintCard), -1);
    });

    test("Choose and Play Card", () async {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);

      final future = customGame.players[0].play(customGame);

      customGame.players[0].chooseCard(1);

      await future;

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
    });

    test("Choose and Play Card Cant Be Played", () async {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], PlagueKnightCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], GuardCard);

      final future = customGame.players[0].play(customGame);

      customGame.players[0].chooseCard(10);

      await Future.delayed(Duration(milliseconds: 10));

      customGame.players[0].chooseCard(1);

      await future;

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], GuardCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], PlagueKnightCard);
    });

    test("Play Card With Taget", () async {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], DiseaseHeraldCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], PlagueKnightCard);

      final future = customGame.players[0].playCard(customGame, 8);

      customGame.players[0].choosePlayer(1);

      await future;

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 9);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], DiseaseHeraldCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], PlagueKnightCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[1], PlagueKnightCard);
    });

    test("Play Card With Two Taget", () async {
      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 11);
      CardsVerifier.verifyPlayerNbCard(customGame.players[2], 11);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsInDeck(customGame.players[0], ThiefCard);

      final future = customGame.players[0].playCard(customGame, 7);

      customGame.players[0].choosePlayer(1);

      await Future.delayed(Duration(milliseconds: 10));

      customGame.players[0].choosePlayer(2);

      await future;

      CardsVerifier.verifyPlayerNbCard(customGame.players[0], 10);
      CardsVerifier.verifyPlayerNbCard(customGame.players[1], 12);
      CardsVerifier.verifyPlayerNbCard(customGame.players[2], 10);
      CardsVerifier.verifyBattleFieldNbCard(customGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(customGame.players[0], ThiefCard);
    });
  });
}