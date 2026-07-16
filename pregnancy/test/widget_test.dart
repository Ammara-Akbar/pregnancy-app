import 'package:flutter_test/flutter_test.dart';
import 'package:pregnancy/main.dart';

void main() {
  testWidgets('App boots to splash branding', (WidgetTester tester) async {
    await tester.pumpWidget(const SehatMaaApp());
    await tester.pump();

    expect(find.text('Guidance. Support. Care.'), findsOneWidget);
    expect(find.text('For every step of motherhood.'), findsOneWidget);
    expect(
      find.text('Preparing your personalized experience...'),
      findsOneWidget,
    );
  });
}
