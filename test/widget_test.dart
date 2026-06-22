import 'package:flutter_test/flutter_test.dart';
import 'package:local_services/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify title exists (ensure this matches the exact text in your HomeScreen)
    expect(find.text('خدمات محلی'), findsOneWidget);

    // Verify search hint text
    expect(find.text('جستجو...'), findsOneWidget); // Note: Changed from '... جستجو' to match your code

    // Verify service cards exist
    // Note: These will only pass if these specific names are in your ServiceData.allServices
    expect(find.text('تاسیسات احمد'), findsOneWidget);
    expect(find.text('خدمات برقی کریمی'), findsOneWidget);
  });
}