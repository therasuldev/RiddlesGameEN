import 'package:flutter_test/flutter_test.dart';
import 'package:riddles_game_en/core/app/riddle.dart';
import 'package:riddles_game_en/riddles_games_en.dart';

import '../../utils.dart';

void main() {
  late R2StatefulWidget testStatefulWidgetR2;
  late R2StatelessWidget testStatelessWidgetR2;
  late R2StatefulWidget testR2;

  Riddle? ridd;

  setUpAll(() {
    testStatefulWidgetR2 = TestStatefulWidget();
    testStatelessWidgetR2 = TestStatelessWidget();
    testR2 = TestR2State();

    ridd = Riddle();
  });

  group("[R2 Widgets]", () {
    test("Check if singleton exists", () {
      expect(ridd, testStatefulWidgetR2.ridd);
      expect(ridd, testStatelessWidgetR2.ridd);
      expect(ridd, testR2.ridd);
    });
  });
}
