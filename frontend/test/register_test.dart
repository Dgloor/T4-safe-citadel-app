import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safecitadel/screens/register/components/body.dart';

void main() {
  testWidgets("Visitor name field is empty", (WidgetTester tester) async{
    final visitorNameField = find.byKey(const ValueKey("visitorNameField"));
    final registerVisitButton = find.byKey(const ValueKey("registerVisitButton"));
    await tester.pumpWidget(const MaterialApp(home: Body()));
    await tester.enterText(visitorNameField, "");
    await tester.tap(registerVisitButton);
    await tester.pump();
    expect(find.text("Ingrese nombre de la visita"), findsOneWidget);
  });


  // testWidgets("Visitor name field is not empty", (WidgetTester tester) async{
  //   final visitorNameField = find.byKey(const ValueKey("visitorNameField"));
  //   final registerVisitButton = find.byKey(const ValueKey("registerVisitButton"));

  //   await tester.pumpWidget(const MaterialApp(home: Body()));
  //   await tester.enterText(visitorNameField, "Juan Perez");
  //   await tester.tap(registerVisitButton);
  //   await tester.pump(const Duration(seconds: 10));   
  //   expect(find.byKey(const ValueKey("qrCode")), findsOneWidget);
  // });
  // testWidgets("Success cancel specific visit", (WidgetTester tester) async{
  //   final visitorNameField = find.byKey(const ValueKey("visitorNameField"));
  //   final registerVisitButton = find.byKey(const ValueKey("registerVisitButton"));

  //   await tester.pumpWidget(const MaterialApp(home: Body()));
  //   await tester.enterText(visitorNameField, "Juan Perez");
  //   await tester.tap(registerVisitButton);
  //   await tester.pump(const Duration(seconds: 10));   
  //   expect(find.byKey(const ValueKey("qrCode")), findsOneWidget);
  // });
}