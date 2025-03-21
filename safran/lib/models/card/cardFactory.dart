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

import '../game.dart';
import 'Constantes/descriptionCardConstante.dart';
import 'Constantes/nameCardConstante.dart';
import 'card.dart';

class CardFactory {

  Game game;
  CardFactory(this.game);

  createDeck(int commanderCardCount, int armyCardCount, int mageCardCount, int thielfCardCount) {
    List<Card> deck = [];

    // Check if total card count is 61 (12 triad cards)
    int totalCardCount = commanderCardCount + armyCardCount + mageCardCount + thielfCardCount + 12;

    if(totalCardCount != 61) {
      throw new Exception("Total card count must be 61");
    }

    deck.addAll(createRecruitmentCards(commanderCardCount, armyCardCount, mageCardCount, thielfCardCount));
    deck.addAll(createTriadCards());
  }

  createArmyCards(int count) {
    List<ArmyCard> armyCardsDeck = [];

    for(int i = 0; i < count; i + 3) {
      armyCardsDeck.add(GardCard(NameCardConstante.GARDE, DescriptionCardConstante.GARDE, "", game));
      armyCardsDeck.add(SwordsmanCard(NameCardConstante.SWORSDMAN, DescriptionCardConstante.SWORSDMAN, "", game));
      armyCardsDeck.add(SpearmanCard(NameCardConstante.SPEARMAN, DescriptionCardConstante.SPEARMAN, "", game));
    }

    return armyCardsDeck;
  }

  createMageCards(int count) {
    List<MageCard> mageCardsDeck = [];

    for(int i = 0; i < count; i + 5) {
      mageCardsDeck.add(GeomancerCard(NameCardConstante.GEOMANCER, DescriptionCardConstante.GEOMANCER, "", game));
      mageCardsDeck.add(GeomancerCard(NameCardConstante.GEOMANCER, DescriptionCardConstante.GEOMANCER, "", game));

      mageCardsDeck.add(AeromancerCard(NameCardConstante.AEROMANCER, DescriptionCardConstante.AEROMANCER, "", game));
      mageCardsDeck.add(AeromancerCard(NameCardConstante.AEROMANCER, DescriptionCardConstante.AEROMANCER, "", game));

      mageCardsDeck.add(ArcanistCard(NameCardConstante.ARCANIST, DescriptionCardConstante.ARCANIST, "", game));
    }

    return mageCardsDeck;
  }

  createRecruitmentCards(int commanderCardCount, int armyCardCount, int mageCardCount, int thielfCardCount) {
    List<RecruitmentCard> recruitmentCardsDeck = [];
    for (int i = 0; i < commanderCardCount; i++) {
      recruitmentCardsDeck.add(CommanderCard(NameCardConstante.COMMANDER, DescriptionCardConstante.COMMANDER, "", game));
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
      recruitmentCardsDeck.add(ThielfCard(NameCardConstante.THIELF, DescriptionCardConstante.THIELF, "", game));
    }

    return recruitmentCardsDeck;
  }

  createHeraldCards() {
    List<FateHeraldCard> heraldCardsDeck = [];
    
    heraldCardsDeck.add(ChaosHeraldCard(NameCardConstante.CHAOSHERALD, DescriptionCardConstante.CHAOSHERALD, "", game));
    heraldCardsDeck.add(DiseaseHeraldCard(NameCardConstante.DISEASEHERALD, DescriptionCardConstante.DISEASEHERALD, "", game));
    heraldCardsDeck.add(PowerHeraldCard(NameCardConstante.POWERHERALD, DescriptionCardConstante.POWERHERALD, "", game));
    heraldCardsDeck.add(SufferingHeraldCard(NameCardConstante.SUFFERINGHERALD, DescriptionCardConstante.SUFFERINGHERALD, "", game));

    return heraldCardsDeck;
  }

  createSaintCards() {
    List<FateHeraldCard> saintCardsDeck = [];

    saintCardsDeck.add(AbundanceSaintCard(NameCardConstante.ABUNDANCESAINT, DescriptionCardConstante.ABUNDANCESAINT, "", game) as FateHeraldCard);
    saintCardsDeck.add(HealingSaintCard(NameCardConstante.HEALINGSAINT, DescriptionCardConstante.HEALINGSAINT, "", game) as FateHeraldCard);
    saintCardsDeck.add(PeaceSaintCard(NameCardConstante.PEACESAINT, DescriptionCardConstante.PEACESAINT, "", game) as FateHeraldCard);
    saintCardsDeck.add(ProsperitySaintCard(NameCardConstante.PROSPERITYSAINT, DescriptionCardConstante.PROSPERITYSAINT, "", game) as FateHeraldCard);

    return saintCardsDeck;
  }

  createKnightCards() {
    List<FateHeraldCard> knightCardsDeck = [];

    knightCardsDeck.add(ConquestKnightCard(NameCardConstante.CONQUESTKNIGHT, DescriptionCardConstante.CONQUESTKNIGHT, "", game) as FateHeraldCard);
    knightCardsDeck.add(FamineKnightCard(NameCardConstante.FAMINEKNIGHT, DescriptionCardConstante.FAMINEKNIGHT, "", game) as FateHeraldCard);
    knightCardsDeck.add(PlagueKnightCard(NameCardConstante.PLAGUEKNIGHT, DescriptionCardConstante.PLAGUEKNIGHT, "", game) as FateHeraldCard);
    knightCardsDeck.add(WarKnightCard(NameCardConstante.WARKNIGHT, DescriptionCardConstante.WARKNIGHT, "", game) as FateHeraldCard);

    return knightCardsDeck;
  }

  createTriadCards() {
    List<FateHeraldCard> triadCardsDeck = [];

    triadCardsDeck.addAll(createHeraldCards());
    triadCardsDeck.addAll(createSaintCards());
    triadCardsDeck.addAll(createKnightCards());

    return triadCardsDeck;
  }
}