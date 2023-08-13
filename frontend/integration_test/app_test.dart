import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:safecitadel/main.dart' as app;
import 'package:safecitadel/screens/home/home_screen.dart';
void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end to end test', (){
    testWidgets('Login test', (WidgetTester tester) async{
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key('usernameField')), "alanbarco");
      await tester.enterText(find.byKey(Key('passwordField')), "123123123");
      await tester.tap(find.byKey(Key("loginButton")));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}