// Basic smoke test for JourneyCanvas
import 'package:flutter_test/flutter_test.dart';
import 'package:journey_canvas/main.dart';

void main() {
  testWidgets('JourneyCanvas app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JourneyCanvasApp());
    expect(find.byType(JourneyCanvasApp), findsOneWidget);
  });
}
