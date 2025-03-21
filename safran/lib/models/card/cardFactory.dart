import 'package:safran/models/card/recruitment/army/armyCard.dart';
import 'package:safran/models/card/recruitment/army/gardCard.dart';
import 'package:safran/models/card/recruitment/army/spearmanCard.dart';
import 'package:safran/models/card/recruitment/army/swordsmanCard.dart';
import 'package:safran/models/card/recruitment/commanderCard.dart';
import 'package:safran/models/card/recruitment/mage/aeromancerCard.dart';
import 'package:safran/models/card/recruitment/mage/arcanistCard.dart';
import 'package:safran/models/card/recruitment/mage/geomancerCard.dart';
import 'package:safran/models/card/recruitment/mage/mageCard.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';
import 'package:safran/models/card/recruitment/thielfCard.dart';
import 'package:safran/models/card/triad/cursedKnight/conquestKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/cursedKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/famineKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/plagueKnightCard.dart';
import 'package:safran/models/card/triad/cursedKnight/warKnightCard.dart';
import 'package:safran/models/card/triad/fateHerald/chaosHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/diseaseHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/fateHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/powerHeraldCard.dart';
import 'package:safran/models/card/triad/fateHerald/sufferingHeraldCard.dart';
import 'package:safran/models/card/triad/saintProtector/abundanceSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/healingSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/peaceSaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/prosperitySaintCard.dart';
import 'package:safran/models/card/triad/saintProtector/saintProtectorCard.dart';
import 'package:safran/models/card/triad/triadCard.dart';

import '../game.dart';
import 'card.dart';

class CardFactory {

  Game game;
  CardFactory(this.game);

  createDeck(int commanderCardCount, int armyCardCount, int mageCardCount, int thielfCardCount) {
    List<Card> deckList = [];

    // Check if total card count is 61 (12 triad cards)
    int totalCardCount = commanderCardCount + armyCardCount + mageCardCount + thielfCardCount + 12;

    if(totalCardCount != 61) {
      throw new Exception("Total card count must be 61");
    }

    deckList.addAll(createRecruitmentCards(commanderCardCount, armyCardCount, mageCardCount, thielfCardCount));
    deckList.addAll(createTriadCards());

    return deckList;
  }

  createArmyCards(int count) {
    List<ArmyCard> armyCardsDeck = [];

    for(int i = 0; i < count; i += 3) {
      armyCardsDeck.add(GardCard(game));
      armyCardsDeck.add(SwordsmanCard(game));
      armyCardsDeck.add(SpearmanCard(game));
    }

    return armyCardsDeck;
  }

  createMageCards(int count) {
    List<MageCard> mageCardsDeck = [];

    for(int i = 0; i < count; i += 5) {
      mageCardsDeck.add(GeomancerCard(game));
      mageCardsDeck.add(GeomancerCard(game));

      mageCardsDeck.add(AeromancerCard(game));
      mageCardsDeck.add(AeromancerCard(game));

      mageCardsDeck.add(ArcanistCard(game));
    }

    return mageCardsDeck;
  }

  createRecruitmentCards(int commanderCardCount, int armyCardCount, int mageCardCount, int thielfCardCount) {
    List<RecruitmentCard> recruitmentCardsDeck = [];
    for (int i = 0; i < commanderCardCount; i++) {
      recruitmentCardsDeck.add(CommanderCard(game));
    }

    if(armyCardCount % 3 != 0) {
      throw new Exception("Army card count must be a multiple of 3");
    } else {
      recruitmentCardsDeck.addAll(createArmyCards(armyCardCount));
    }

    if(mageCardCount % 5 != 0) {
      throw new Exception("Mage card count must be a multiple of 5");
    } else {
      recruitmentCardsDeck.addAll(createMageCards(mageCardCount));
    }

    for (int i = 0; i < thielfCardCount; i++) {
      recruitmentCardsDeck.add(ThielfCard(game));
    }

    return recruitmentCardsDeck;
  }

  createHeraldCards() {
    List<FateHeraldCard> heraldCardsDeck = [];
    
    heraldCardsDeck.add(ChaosHeraldCard(game));
    heraldCardsDeck.add(DiseaseHeraldCard(game));
    heraldCardsDeck.add(PowerHeraldCard(game));
    heraldCardsDeck.add(SufferingHeraldCard(game));

    return heraldCardsDeck;
  }

  createSaintCards() {
    List<SaintProtectorCard> saintCardsDeck = [];

    saintCardsDeck.add(AbundanceSaintCard(game));
    saintCardsDeck.add(HealingSaintCard(game));
    saintCardsDeck.add(PeaceSaintCard(game));
    saintCardsDeck.add(ProsperitySaintCard(game));

    return saintCardsDeck;
  }

  createKnightCards() {
    List<CursedKnightCard> knightCardsDeck = [];

    knightCardsDeck.add(ConquestKnightCard(game));
    knightCardsDeck.add(FamineKnightCard(game));
    knightCardsDeck.add(PlagueKnightCard(game));
    knightCardsDeck.add(WarKnightCard(game));

    return knightCardsDeck;
  }

  createTriadCards() {
    List<TriadCard> triadCardsDeck = [];

    triadCardsDeck.addAll(createHeraldCards());
    triadCardsDeck.addAll(createSaintCards());
    triadCardsDeck.addAll(createKnightCards());

    return triadCardsDeck;
  }
}