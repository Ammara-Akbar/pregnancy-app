import 'package:flutter_test/flutter_test.dart';
import 'package:pregnancy/main.dart';

void main() {
  testWidgets('App boots to splash branding', (WidgetTester tester) async {
    await tester.pumpWidget(const SehatMaaApp());
    await tester.pump();

    expect(find.text('Sehat Maa'), findsOneWidget);
    expect(
      find.text('Your Pregnancy & Motherhood Companion'),
      findsOneWidget,
    );
  });
}
