import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nfstock_test/screens/markets_screen.dart';
import 'package:nfstock_test/widgets/asset_view.dart';

void main() {
  testWidgets('Markets screen renders without crashing and renders assets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MarketsScreen()));

    // Verify that our counter starts at 0.
    expect(find.byType(MarketsScreen), findsOneWidget);
    expect(find.byType(AssetView), findsWidgets);
  });
}
