import 'package:safran/models/card/constant/descriptionCardConstante.dart';
import 'package:safran/models/card/constant/nameCardConstante.dart';
import 'package:safran/models/card/constant/pictureCardConstant.dart';
import 'package:safran/models/card/recruitment/recruitmentCard.dart';
import 'package:safran/models/player.dart';

class ThielfCard extends RecruitmentCard {
  ThielfCard(game)
      : super(NameCardConstant.THIELF, DescriptionCardConstant.THIELF,
            PictureCardConstant.THIELF, game);

  play(Player player1, Player player2) {
    game.transferCardPlayerToPlayer(player1, player2);
  }
}
