import 'package:safran/entities/card/game_card.dart';
import 'package:safran/entities/game.dart';

class FakeCard extends GameCard {
  FakeCard() : super("FakeCard", "Fake card for testing", "fake_image.png", true);

  @override
  void play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    // Do nothing for the fake card
  }
}