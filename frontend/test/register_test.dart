import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba/screens/register/components/body.dart';


void main() {
  testWidgets("Visitor name field is empty", (WidgetTester tester) async{
    final visitorNameField = find.byKey(ValueKey("visitorNameField"));
    final registerVisitButton = find.byKey(ValueKey("registerVisitButton"));


    await tester.pumpWidget(MaterialApp(home: Body()));
    await tester.enterText(visitorNameField, "");
    await tester.tap(registerVisitButton);
    await tester.pump();

    expect(find.text("Ingrese nombre de la visita"), findsOneWidget);
  });


  testWidgets("Visitor name field is not empty", (WidgetTester tester) async{
    final visitorNameField = find.byKey(ValueKey("visitorNameField"));
    final registerVisitButton = find.byKey(ValueKey("registerVisitButton"));


    await tester.pumpWidget(MaterialApp(home: Body()));
    await tester.enterText(visitorNameField, "Juan Perez");
    await tester.tap(registerVisitButton);
    await tester.pump(Duration(seconds: 10));   
    expect(find.byKey(ValueKey("qrCode")), findsOneWidget);
  });

}