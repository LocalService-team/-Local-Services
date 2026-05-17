import 'package:flutter_test/flutter_test.dart';
import 'package:local_servieces/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify title exists
    expect(find.text('خدمات محلی'), findsOneWidget);

    // Verify search field exists
    expect(find.text('... جستجو'), findsOneWidget);

    // Verify service cards exist
    expect(find.text('نانوایی احمد'), findsOneWidget);
    expect(find.text('دواخانه سلام'), findsOneWidget);
  });
}