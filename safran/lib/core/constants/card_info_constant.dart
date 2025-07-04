class CardInfo {
  final String name;
  final String description;
  final String image;
  final bool canPlay;

  CardInfo(this.name, this.description, this.image, this.canPlay);

  // Recruitment cards
  static CardInfo commander = CardInfo("Commandant", "", "", true);

  static CardInfo guard = CardInfo("Garde", "", "", true);
  static CardInfo archer = CardInfo("Archer", "", "", true);
  static CardInfo swordsman = CardInfo("Epeiste", "", "", true);

  static CardInfo geomancer = CardInfo("Geomancien", "", "", true);
  static CardInfo aeromancer = CardInfo("Aeromancien", "", "", true);
  static CardInfo arcanist = CardInfo("Arcaniste", "", "", true);

  static CardInfo thief = CardInfo("Voleur", "", "", true);

  // Herald cards
  static CardInfo diseaseHerald = CardInfo("Messager de la Maladie", "", "", true);
  static CardInfo chaosHerald = CardInfo("Messager du Chaos", "", "", true);
  static CardInfo powerHerald = CardInfo("Messager du Pouvoir", "", "", true);
  static CardInfo sufferingHerald = CardInfo("Messager de la Souffrance", "", "", true);

  // Saint cards
  static CardInfo abundanceSaint = CardInfo("Saint de l'Abondance", "", "", true);
  static CardInfo healingSaint = CardInfo("Saint de la Guerison", "", "", true);
  static CardInfo prosperitySaint = CardInfo("Saint de la Prosperite", "", "", true);
  static CardInfo peaceSaint = CardInfo("Saint de la Paix", "", "", true);

  // Knight cards
  static CardInfo conquestKnight = CardInfo("Cavalier de la Conquete", "", "", false);
  static CardInfo famineKnight = CardInfo("Cavalier de la Famine", "", "", false);
  static CardInfo plagueKnight = CardInfo("Cavalier de la Peste", "", "", false);
  static CardInfo warKnight = CardInfo("Cavalier de la Guerre", "", "", false);
}