import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/screens/onboarding/onboarding_screen.dart';

void main() {
  testWidgets('Aplikasi SweetBite Donut memuat halaman Onboarding awal', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    // Memverifikasi teks tagline dan tombol GET STARTED dari Figma
    expect(find.text('ENJOY YOUR FOOD'), findsOneWidget);
    expect(find.text('GET STARTED'), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
