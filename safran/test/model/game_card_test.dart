import 'package:flutter_test/flutter_test.dart';
import 'package:safran/entities/card/game_card.dart';

void main() {
  late List<int> targets;
  late int targetNumber;

  setUp(() {
    targets = [0];
    targetNumber = 2;
  });

  group("Game Cards", () {
    test("have incorecte target number", ()  {
      expect(
            () => GameCard.correctNbTargets(targetNumber, targets),
        throwsA(
          predicate(
                (e) =>
            e is Exception &&
                e.toString() ==
                    'Exception: Invalid number of targets: 2. Expected: 1',
          ),
        ),
      );
    });
  });
}