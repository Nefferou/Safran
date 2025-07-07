class CardInfo {
  final String name;
  final String description;
  final String image;
  final bool canPlay;

  CardInfo(this.name, this.description, this.image, [this.canPlay = true]);

  // Recruitment cards
  static CardInfo commander = CardInfo("Commandant", "", "");

  static CardInfo guard = CardInfo("Garde", "", "");
  static CardInfo archer = CardInfo("Archer", "", "");
  static CardInfo swordsman = CardInfo("Epeiste", "", "");

  static CardInfo geomancer = CardInfo("Geomancien", "", "");
  static CardInfo aeromancer = CardInfo("Aeromancien", "", "");
  static CardInfo arcanist = CardInfo("Arcaniste", "", "");

  static CardInfo thief = CardInfo("Voleur", "", "");

  // Herald cards
  static CardInfo diseaseHerald = CardInfo("Messager de la Maladie", "", "");
  static CardInfo chaosHerald = CardInfo("Messager du Chaos", "", "");
  static CardInfo powerHerald = CardInfo("Messager du Pouvoir", "", "");
  static CardInfo sufferingHerald = CardInfo("Messager de la Souffrance", "", "");

  // Saint cards
  static CardInfo abundanceSaint = CardInfo("Saint de l'Abondance", "", "");
  static CardInfo healingSaint = CardInfo("Saint de la Guerison", "", "");
  static CardInfo prosperitySaint = CardInfo("Saint de la Prosperite", "", "");
  static CardInfo peaceSaint = CardInfo("Saint de la Paix", "", "");

  // Knight cards
  static CardInfo conquestKnight = CardInfo("Cavalier de la Conquete", "", "", false);
  static CardInfo famineKnight = CardInfo("Cavalier de la Famine", "", "", false);
  static CardInfo plagueKnight = CardInfo("Cavalier de la Peste", "", "", false);
  static CardInfo warKnight = CardInfo("Cavalier de la Guerre", "", "", false);
}