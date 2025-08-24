import 'package:safran/entities/card/recruitment/recruitment_card.dart';
import 'package:safran/services/logger.dart';

import '../../../entities/game.dart';
import '../../../core/constants/card_info_constant.dart';

class CommanderCard extends RecruitmentCard {
  CommanderCard()
      : super(CardInfo.commander);

  @override
  void play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    game.battleField.shuffleBattleField();
    Logger.info("commandant");
    game.changePlayOrder();
  }
}
