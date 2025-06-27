import 'package:safran/models/card/constant/card_creation_constant.dart';
import 'package:safran/models/card/recruitment/army/army_card.dart';
import 'package:safran/models/card/recruitment/army/guard_card.dart';
import 'package:safran/models/card/recruitment/army/archer_card.dart';
import 'package:safran/models/card/recruitment/army/swordsman_card.dart';
import 'package:safran/models/card/recruitment/commander_card.dart';
import 'package:safran/models/card/recruitment/mage/aeromancer_card.dart';
import 'package:safran/models/card/recruitment/mage/arcanist_card.dart';
import 'package:safran/models/card/recruitment/mage/geomancer_card.dart';
import 'package:safran/models/card/recruitment/mage/mage_card.dart';
import 'package:safran/models/card/recruitment/recruitment_card.dart';
import 'package:safran/models/card/recruitment/thief_card.dart';
import 'package:safran/models/card/triad/cursedKnight/conquest_knight_card.dart';
import 'package:safran/models/card/triad/cursedKnight/famine_knight_card.dart';
import 'package:safran/models/card/triad/cursedKnight/plague_knight_card.dart';
import 'package:safran/models/card/triad/cursedKnight/war_knight_card.dart';
import 'package:safran/models/card/triad/fateHerald/chaos_herald_card.dart';
import 'package:safran/models/card/triad/fateHerald/disease_herald_card.dart';
import 'package:safran/models/card/triad/fateHerald/power_herald_card.dart';
import 'package:safran/models/card/triad/fateHerald/suffering_herald_card.dart';
import 'package:safran/models/card/triad/saintProtector/abundance_saint_card.dart';
import 'package:safran/models/card/triad/saintProtector/healing_saint_card.dart';
import 'package:safran/models/card/triad/saintProtector/peace_saint_card.dart';
import 'package:safran/models/card/triad/triad_card.dart';

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
        ArcherCard(),
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
