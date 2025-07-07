import '../game_card.dart';

abstract class TriadCard extends GameCard {
  TriadCard(cardInfo)
      : super(cardInfo.name, cardInfo.description, cardInfo.image, cardInfo.canPlay);
}