import '../../../entities/game.dart';
import '../../../core/constants/card_info_constant.dart';
import '../game_card.dart';

abstract class RecruitmentCard extends GameCard {
  RecruitmentCard(CardInfo cardInfo)
      : super(cardInfo.name, cardInfo.description, cardInfo.image);

  @override
  play(Game game, [List<int> targets = const [], bool activateEffect = true]);
}