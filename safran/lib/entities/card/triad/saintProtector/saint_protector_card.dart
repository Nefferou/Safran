import 'package:safran/entities/card/triad/triad_card.dart';

import '../../../../entities/game.dart';

abstract class SaintProtectorCard extends TriadCard {

  SaintProtectorCard(super.cardInfo);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}