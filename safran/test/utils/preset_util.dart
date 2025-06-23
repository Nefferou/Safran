import 'package:safran/models/battleField.dart';
import 'package:safran/models/card/card_factory.dart';
import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/card/recruitment/army/gardCard.dart';
import 'package:safran/models/card/recruitment/army/spearmanCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/card/recruitment/mage/aeromancerCard.dart';
import 'package:safran/models/card/recruitment/mage/arcanistCard.dart';
import 'package:safran/models/card/recruitment/mage/geomancerCard.dart';
import 'package:safran/models/card/recruitment/thiefCard.dart';
import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/famineKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/warKnightCard.dart';
import 'package:safran/models/card/triad/fateHerald/chaosHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/diseaseHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/powerHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/sufferingHeraldCard.dart';
import 'package:safran/models/card/triad/saintProtector/abundanceSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/healingSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/peaceSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/prosperitySaintCard.dart';
import 'package:safran/models/game.dart';
import 'package:safran/models/player.dart';

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
      SpearmanCard(),
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
      SpearmanCard(),
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
      SpearmanCard(),
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
      SpearmanCard(),
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
      SpearmanCard(),
      SwordsmanCard()
    ]);

    Game game = Game([player1, player2, player3, player4]);
    game.battleField = battleField;
    setUpGame(game);

    return game;
  }
}
