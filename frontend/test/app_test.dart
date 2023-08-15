import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:safecitadel/main.dart' as app;
import 'package:safecitadel/screens/home/home_screen.dart';
void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end to end test', (){
    testWidgets('Successful login test', (WidgetTester tester) async{
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(Key("continueButton")));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key('usernameField')), "alanbarco");
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byKey(Key('passwordField')), "abc123abc");
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(Key("loginButton")));
      await Future.delayed(const Duration(seconds: 20));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Unsuccessful login test', (WidgetTester tester) async{
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(Key("continueButton")));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key('usernameField')), "alanbarco");
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(find.byKey(Key('passwordField')), "abcabcabc");
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(Key("loginButton")));
      await Future.delayed(const Duration(seconds: 10));
      await tester.pumpAndSettle();
      expect(find.text("Credenciales incorrectas."), findsOneWidget);
    });
  });
}