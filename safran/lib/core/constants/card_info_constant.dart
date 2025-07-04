class CardInfo {
  final String name;
  final String description;
  final String image;
  final bool canPlay;

  CardInfo(this.name, this.description, this.image, this.canPlay);
  CardInfo.playabled(this.name, this.description, this.image): canPlay = true;

  // Recruitment cards
  static CardInfo commander = CardInfo.playabled("Commandant", "", "");

  static CardInfo guard = CardInfo.playabled("Garde", "", "");
  static CardInfo archer = CardInfo.playabled("Archer", "", "");
  static CardInfo swordsman = CardInfo.playabled("Epeiste", "", "");

  static CardInfo geomancer = CardInfo.playabled("Geomancien", "", "");
  static CardInfo aeromancer = CardInfo.playabled("Aeromancien", "", "");
  static CardInfo arcanist = CardInfo.playabled("Arcaniste", "", "");

  static CardInfo thief = CardInfo.playabled("Voleur", "", "");

  // Herald cards
  static CardInfo diseaseHerald = CardInfo.playabled("Messager de la Maladie", "", "");
  static CardInfo chaosHerald = CardInfo.playabled("Messager du Chaos", "", "");
  static CardInfo powerHerald = CardInfo.playabled("Messager du Pouvoir", "", "");
  static CardInfo sufferingHerald = CardInfo.playabled("Messager de la Souffrance", "", "");

  // Saint cards
  static CardInfo abundanceSaint = CardInfo.playabled("Saint de l'Abondance", "", "");
  static CardInfo healingSaint = CardInfo.playabled("Saint de la Guerison", "", "");
  static CardInfo prosperitySaint = CardInfo.playabled("Saint de la Prosperite", "", "");
  static CardInfo peaceSaint = CardInfo.playabled("Saint de la Paix", "", "");

  // Knight cards
  static CardInfo conquestKnight = CardInfo("Cavalier de la Conquete", "", "", false);
  static CardInfo famineKnight = CardInfo("Cavalier de la Famine", "", "", false);
  static CardInfo plagueKnight = CardInfo("Cavalier de la Peste", "", "", false);
  static CardInfo warKnight = CardInfo("Cavalier de la Guerre", "", "", false);
}