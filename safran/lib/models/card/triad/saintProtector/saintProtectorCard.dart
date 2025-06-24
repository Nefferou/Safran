import 'package:safran/models/card/triad/triadCard.dart';

import '../../../game.dart';

abstract class SaintProtectorCard extends TriadCard {

  SaintProtectorCard(super.name, super.description, super.image);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}