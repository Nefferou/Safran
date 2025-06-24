import 'package:safran/models/card/game_card.dart';
import 'package:safran/models/game.dart';

class FakeCard extends GameCard {
  FakeCard() : super("FakeCard", "Fake card for testing", "fake_image.png");

  @override
  void play(Game game, [List<int> targets = const [], bool activateEffect = true]) {
    // Do nothing for the fake card
  }
}