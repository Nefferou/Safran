import 'package:safran/entities/battle_field.dart';
import 'package:safran/services/card_factory.dart';
import 'package:safran/entities/card/recruitment/army/archer_card.dart';
import 'package:safran/entities/card/recruitment/army/guard_card.dart';
import 'package:safran/entities/card/recruitment/army/swordsman_card.dart';
import 'package:safran/entities/card/recruitment/commander_card.dart';
import 'package:safran/entities/card/recruitment/mage/aeromancer_card.dart';
import 'package:safran/entities/card/recruitment/mage/arcanist_card.dart';
import 'package:safran/entities/card/recruitment/mage/geomancer_card.dart';
import 'package:safran/entities/card/recruitment/thief_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/conquest_knight_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/famine_knight_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/plague_knight_card.dart';
import 'package:safran/entities/card/triad/cursedKnight/war_knight_card.dart';
import 'package:safran/entities/card/triad/fateHerald/chaos_herald_card.dart';
import 'package:safran/entities/card/triad/fateHerald/disease_herald_card.dart';
import 'package:safran/entities/card/triad/fateHerald/power_herald_card.dart';
import 'package:safran/entities/card/triad/fateHerald/suffering_herald_card.dart';
import 'package:safran/entities/card/triad/saintProtector/abundance_saint_card.dart';
import 'package:safran/entities/card/triad/saintProtector/healing_saint_card.dart';
import 'package:safran/entities/card/triad/saintProtector/peace_saint_card.dart';
import 'package:safran/entities/card/triad/saintProtector/prosperity_saint_card.dart';
import 'package:safran/entities/game.dart';
import 'package:safran/entities/player.dart';

class PresetUtil {

  static setUpGame(game) {
    game.playOrder = true;
    game.battleMode = false;
    game.isSetup = true;
    game.isInPause = false;
    game.isGameOver = false;
    game.currentPlayerTurn = 0;
    game.cardFactory = CardFactory(game);
  }

  static Game presetGameWithPlayersEqualyDealed() {
    Player player1 = Player("Player1");
    Player player2 = Player("Player2");
    Player player3 = Player("Player3");
    Player player4 = Player("Player4");
    BattleField battleField = BattleField();

    player1.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard(),
      GeomancerCard(),
      AeromancerCard(),
      ArcanistCard(),
      ThiefCard(),
      DiseaseHeraldCard(),
      HealingSaintCard(),
      PlagueKnightCard()
    ]);

    player2.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard(),
      GeomancerCard(),
      AeromancerCard(),
      ArcanistCard(),
      ThiefCard(),
      SufferingHeraldCard(),
      AbundanceSaintCard(),
      FamineKnightCard()
    ]);

    player3.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard(),
      GeomancerCard(),
      AeromancerCard(),
      ArcanistCard(),
      ThiefCard(),
      ChaosHeraldCard(),
      PeaceSaintCard(),
      WarKnightCard()
    ]);

    player4.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard(),
      GeomancerCard(),
      AeromancerCard(),
      ArcanistCard(),
      ThiefCard(),
      PowerHeraldCard(),
      ProsperitySaintCard(),
      ConquestKnightCard()
    ]);

    battleField.cards.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard()
    ]);

    Game game = Game([player1, player2, player3, player4]);
    game.battleField = battleField;
    setUpGame(game);

    return game;
  }

  static Game presetCanPlayKnight() {
    Player player1 = Player("Player1");
    Player player2 = Player("Player2");
    Player player3 = Player("Player3");
    BattleField battleField = BattleField();

    player1.deck.addAll([
      WarKnightCard(),
      PlagueKnightCard()
    ]);

    player2.deck.addAll([
      CommanderCard(),
      GuardCard(),
      FamineKnightCard()
    ]);

    player3.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
    ]);

    battleField.cards.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard()
    ]);

    Game game = Game([player1, player2, player3]);
    game.battleField = battleField;
    setUpGame(game);

    return game;
  }

  static Game presetCanPlayCard() {
    Player player1 = Player("Player1");
    Player player2 = Player("Player2");
    Player player3 = Player("Player3");
    BattleField battleField = BattleField();

    player1.deck.addAll([
      WarKnightCard(),
      PlagueKnightCard(),
      SwordsmanCard()
    ]);

    player2.deck.addAll([
      GuardCard(),
      FamineKnightCard()
    ]);

    player3.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
    ]);

    battleField.cards.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard()
    ]);

    Game game = Game([player1, player2, player3]);
    game.battleField = battleField;
    setUpGame(game);

    return game;
  }

  static Game presetArmy() {
    Player player1 = Player("Player1");
    Player player2 = Player("Player2");
    Player player3 = Player("Player3");
    BattleField battleField = BattleField();

    player1.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard()
    ]);

    player2.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard()
    ]);

    player3.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard()
    ]);

    battleField.cards.addAll([
      CommanderCard(),
      ThiefCard(),
    ]);

    Game game = Game([player1, player2, player3]);
    game.battleField = battleField;
    setUpGame(game);

    return game;
  }

  static Game presetRobPlagueKnight() {
    Player player1 = Player("Player1");
    Player player2 = Player("Player2");
    Player player3 = Player("Player3");
    BattleField battleField = BattleField();

    player1.deck.addAll([
      GuardCard(),
      ArcherCard(),
      ThiefCard()
    ]);

    player2.deck.addAll([
      PlagueKnightCard()
    ]);

    player3.deck.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
    ]);

    battleField.cards.addAll([
      CommanderCard(),
      GuardCard(),
      ArcherCard(),
      SwordsmanCard()
    ]);

    Game game = Game([player1, player2, player3]);
    game.battleField = battleField;
    setUpGame(game);

    return game;
  }
}
