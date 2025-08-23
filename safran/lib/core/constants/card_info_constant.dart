class CardInfo {
  final String name;
  final String description;
  final String image;
  final bool canPlay;

  CardInfo(this.name, this.description, this.image, [this.canPlay = true]);

  // Recruitment cards
  static CardInfo commander = CardInfo("Commandant", "", "commander.png");

  static CardInfo guard = CardInfo("Garde", "", "guard.png");
  static CardInfo archer = CardInfo("Archer", "", "archer.png");
  static CardInfo swordsman = CardInfo("Epeiste", "", "swordsman.png");

  static CardInfo geomancer = CardInfo("Geomancien", "", "geomancer.png");
  static CardInfo aeromancer = CardInfo("Aeromancien", "", "aeromancer.png");
  static CardInfo arcanist = CardInfo("Arcaniste", "", "arcanist.png");

  static CardInfo thief = CardInfo("Voleur", "", "thief.png");

  // Herald cards
  static CardInfo diseaseHerald = CardInfo("Messager de la Maladie", "", "disease_herald.png");
  static CardInfo chaosHerald = CardInfo("Messager du Chaos", "", "chaos_herald.png");
  static CardInfo powerHerald = CardInfo("Messager du Pouvoir", "", "power_herald.png");
  static CardInfo sufferingHerald = CardInfo("Messager de la Souffrance", "", "suffering_herald.png");

  // Saint cards
  static CardInfo abundanceSaint = CardInfo("Saint de l'Abondance", "", "abundance_saint.png");
  static CardInfo healingSaint = CardInfo("Saint de la Guerison", "", "healing_saint.png");
  static CardInfo prosperitySaint = CardInfo("Saint de la Prosperite", "", "prosperity_saint.png");
  static CardInfo peaceSaint = CardInfo("Saint de la Paix", "", "peace_saint.png");

  // Knight cards
  static CardInfo conquestKnight = CardInfo("Cavalier de la Conquete", "", "conquest_knight.png", false);
  static CardInfo famineKnight = CardInfo("Cavalier de la Famine", "", "famine_knight.png", false);
  static CardInfo plagueKnight = CardInfo("Cavalier de la Peste", "", "plague_knight.png", false);
  static CardInfo warKnight = CardInfo("Cavalier de la Guerre", "", "war_knight.png", false);
}