import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:wallet_connect/keys.dart';
import 'package:wallet_connect/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'Enter email -> Verify screen -> Welcome page',
      (WidgetTester tester) async {
        await app.main();
        await tester.pumpAndSettle();

        expect(find.byKey(Keys.homeKey), findsOneWidget);

        await tester.tap(find.byKey(Keys.inputToggleKey));
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(Keys.emailInputKey),
          'hextools1@gmail.com',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(Keys.submitKey));
        await tester.pumpAndSettle(const Duration(seconds: 5));

        expect(find.byKey(Keys.welcomeKey), findsOneWidget);
      },
    );
  });
}
