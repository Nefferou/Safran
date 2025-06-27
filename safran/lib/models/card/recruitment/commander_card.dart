import 'package:safran/models/card/recruitment/recruitment_card.dart';

import '../../game.dart';
import '../constant/card_info.dart';

class CommanderCard extends RecruitmentCard {
  CommanderCard()
      : super(CardInfo.commander);

  @override
  void play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    game.battleField.shuffleBattleField();
    game.changePlayOrder();
  }
}
