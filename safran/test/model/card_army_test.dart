import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/card/recruitment/army/archer_card.dart';
import 'package:safran/entities/card/recruitment/army/guard_card.dart';
import 'package:safran/entities/card/recruitment/army/swordsman_card.dart';
import 'package:safran/entities/game.dart';
import '../utils/cards_verifier.dart';
import '../utils/preset_util.dart';

void main() {
  late Game armyGame;

  setUp(() {
    armyGame = PresetUtil.presetArmy();
  });

  group("Cards Army tests", () {
    test("Card Guard (Counter OK)", () {
      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[0], ArcherCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[1], GuardCard);

      int indexCardArcher =
          CardsVerifier.getIndexCardByType(armyGame.players[0], ArcherCard);
      int indexCard2 =
          CardsVerifier.getIndexCardByType(armyGame.players[1], GuardCard);

      expect(armyGame.battleMode, false);

      armyGame.players[0].playCard(armyGame, indexCardArcher);
      expect(armyGame.battleMode, true);

      armyGame.nextTurn();

      armyGame.players[1].playCard(armyGame, indexCard2);
      expect(armyGame.battleMode, true);

      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 2);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[0], ArcherCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[1], GuardCard);
    });

    test("Card Guard (Counter KO)", () {
      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[0], SwordsmanCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[1], GuardCard);

      int indexCard1 = CardsVerifier.getIndexCardByType(
          armyGame.players[0], SwordsmanCard);
      int indexCard2 =
          CardsVerifier.getIndexCardByType(armyGame.players[1], GuardCard);

      expect(armyGame.battleMode, false);

      armyGame.players[0].playCard(armyGame, indexCard1);
      expect(armyGame.battleMode, true);

      armyGame.nextTurn();

      armyGame.players[1].playCard(armyGame, indexCard2);
      expect(armyGame.battleMode, true);

      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 3);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[0], SwordsmanCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[1], GuardCard);
    });

    test("Card Spearman (Counter OK)", () {
      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[0], SwordsmanCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[1], ArcherCard);

      int indexCard1 = CardsVerifier.getIndexCardByType(
          armyGame.players[0], SwordsmanCard);
      int indexCard2 =
          CardsVerifier.getIndexCardByType(armyGame.players[1], ArcherCard);

      expect(armyGame.battleMode, false);

      armyGame.players[0].playCard(armyGame, indexCard1);
      expect(armyGame.battleMode, true);

      armyGame.nextTurn();

      armyGame.players[1].playCard(armyGame, indexCard2);
      expect(armyGame.battleMode, true);

      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 2);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[0], SwordsmanCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[1], ArcherCard);
    });

    test("Card Spearman (Counter KO)", () {
      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[0], GuardCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[1], ArcherCard);

      int indexCard1 =
          CardsVerifier.getIndexCardByType(armyGame.players[0], GuardCard);
      int indexCard2 =
          CardsVerifier.getIndexCardByType(armyGame.players[1], ArcherCard);

      expect(armyGame.battleMode, false);

      armyGame.players[0].playCard(armyGame, indexCard1);
      expect(armyGame.battleMode, true);

      armyGame.nextTurn();

      armyGame.players[1].playCard(armyGame, indexCard2);
      expect(armyGame.battleMode, true);

      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 3);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[0], GuardCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[1], ArcherCard);
    });

    test("Card Swordsman (Counter OK)", () {
      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[0], GuardCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[1], SwordsmanCard);

      int indexCard1 =
          CardsVerifier.getIndexCardByType(armyGame.players[0], GuardCard);
      int indexCard2 = CardsVerifier.getIndexCardByType(
          armyGame.players[1], SwordsmanCard);

      expect(armyGame.battleMode, false);

      armyGame.players[0].playCard(armyGame, indexCard1);
      expect(armyGame.battleMode, true);

      armyGame.nextTurn();

      armyGame.players[1].playCard(armyGame, indexCard2);
      expect(armyGame.battleMode, true);

      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 2);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 5);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[0], GuardCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[1], SwordsmanCard);
    });

    test("Card Swordsman (Counter KO)", () {
      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 4);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 4);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 2);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[0], ArcherCard);
      CardsVerifier.verifyIfCardTypeIsInDeck(
          armyGame.players[1], SwordsmanCard);

      int indexCard1 =
          CardsVerifier.getIndexCardByType(armyGame.players[0], ArcherCard);
      int indexCard2 = CardsVerifier.getIndexCardByType(
          armyGame.players[1], SwordsmanCard);

      expect(armyGame.battleMode, false);

      armyGame.players[0].playCard(armyGame, indexCard1);
      expect(armyGame.battleMode, true);

      armyGame.nextTurn();

      armyGame.players[1].playCard(armyGame, indexCard2);
      expect(armyGame.battleMode, true);

      CardsVerifier.verifyPlayerNbCard(armyGame.players[0], 3);
      CardsVerifier.verifyPlayerNbCard(armyGame.players[1], 3);
      CardsVerifier.verifyBattleFieldNbCard(armyGame.battleField, 4);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[0], ArcherCard);
      CardsVerifier.verifyIfCardTypeIsntInDeck(
          armyGame.players[1], SwordsmanCard);
    });
  });
} 