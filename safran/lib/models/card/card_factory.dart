import 'package:safran/models/card/constant/cardCreationConstant.dart';
import 'package:safran/models/card/recruitment/army/armyCard.dart';
import 'package:safran/models/card/recruitment/army/guardCard.dart';
import 'package:safran/models/card/recruitment/army/spearmanCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/card/recruitment/mage/aeromancerCard.dart';
import 'package:safran/models/card/recruitment/mage/arcanistCard.dart';
import 'package:safran/models/card/recruitment/mage/geomancerCard.dart';
import 'package:safran/models/card/recruitment/mage/mageCard.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';
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
import 'package:safran/models/card/triad/triadCard.dart';

import '../game.dart';
import '../logger.dart';
import 'game_card.dart';

class CardFactory {
  Game game;

  CardFactory(this.game);

  createDeck(int commanderCardCount, int armyCardCount, int mageCardCount,
      int thiefCardCount) {
    Logger.info("Creating deck");
    List<GameCard> deckList = [];

    // Check if total card count is equal to the total defined in CardCreationConstant (+ total of triad cards)
    int totalCardCount = commanderCardCount +
        armyCardCount +
        mageCardCount +
        thiefCardCount +
        CardCreationConstant.TOTAL_TRIAD_CARDS;

    /*
    if(totalCardCount != CardCreationConstant.TOTAL_DECK_SIZE) {
      Logger.warning("Total card count must be ${CardCreationConstant.TOTAL_DECK_SIZE}");
      throw Exception("Total card count must be ${CardCreationConstant.TOTAL_DECK_SIZE}");
    }
    */

    deckList.addAll(createRecruitmentCards(
        commanderCardCount, armyCardCount, mageCardCount, thiefCardCount));
    deckList.addAll(createTriadCards());

    return deckList;
  }

  createArmyCards(int count) {
    List<ArmyCard> armyCardsDeck = [];

    for (int i = 0; i < count; i += CardCreationConstant.ARMY_GROUP_SIZE) {
      armyCardsDeck.addAll([
        GuardCard(),
        SwordsmanCard(),
        SpearmanCard(),
      ]);
    }

    return armyCardsDeck;
  }

  createMageCards(int count) {
    List<MageCard> mageCardsDeck = [];

    final mageGroup = [
      () => GeomancerCard(),
      () => GeomancerCard(),
      () => AeromancerCard(),
      () => AeromancerCard(),
      () => ArcanistCard(),
    ];

    for (int i = 0; i < count; i += CardCreationConstant.MAGE_GROUP_SIZE) {
      mageCardsDeck.addAll(mageGroup.map((create) => create()));
    }

    return mageCardsDeck;
  }

  createRecruitmentCards(int commanderCardCount, int armyCardCount,
      int mageCardCount, int thielfCardCount) {
    List<RecruitmentCard> recruitmentCardsDeck = [];
    for (int i = 0; i < commanderCardCount; i++) {
      recruitmentCardsDeck.add(CommanderCard());
    }

    if (armyCardCount % CardCreationConstant.ARMY_GROUP_SIZE != 0) {
      throw Exception(
          "Army card count must be a multiple of ${CardCreationConstant.ARMY_GROUP_SIZE}");
    } else {
      recruitmentCardsDeck.addAll(createArmyCards(armyCardCount));
    }

    if (mageCardCount % CardCreationConstant.MAGE_GROUP_SIZE != 0) {
      throw Exception(
          "Mage card count must be a multiple of ${CardCreationConstant.MAGE_GROUP_SIZE}");
    } else {
      recruitmentCardsDeck.addAll(createMageCards(mageCardCount));
    }

    for (int i = 0; i < thielfCardCount; i++) {
      recruitmentCardsDeck.add(ThiefCard());
    }

    return recruitmentCardsDeck;
  }

  createHeraldCards() {
    final constructors = [
      () => ChaosHeraldCard(),
      () => PowerHeraldCard(),
      () => SufferingHeraldCard(),
      () => DiseaseHeraldCard(),
    ];
    return constructors.map((c) => c()).toList();
  }

  createSaintCards() {
    final constructors = [
      () => PeaceSaintCard(),
      () => ProsperitySaintCard(),
      () => AbundanceSaintCard(),
      () => HealingSaintCard(),
    ];
    return constructors.map((c) => c()).toList();
  }

  createKnightCards() {
    final constructors = [
      () => WarKnightCard(),
      () => ConquestKnightCard(),
      () => FamineKnightCard(),
      () => PlagueKnightCard(),
    ];
    return constructors.map((c) => c()).toList();
  }

  createTriadCards() {
    List<TriadCard> triadCardsDeck = [];

    triadCardsDeck.addAll(createHeraldCards());
    triadCardsDeck.addAll(createSaintCards());
    triadCardsDeck.addAll(createKnightCards());

    return triadCardsDeck;
  }
}
