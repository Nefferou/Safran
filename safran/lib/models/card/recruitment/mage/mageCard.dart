import 'package:safran/models/card/card_game.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';

abstract class MageCard extends RecruitmentCard{
  MageCard(super.name, super.description, super.image, super.game);
}