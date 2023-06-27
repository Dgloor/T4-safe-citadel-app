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
  testWidgets("Visitor name is not empty", (WidgetTester tester) async{
    final visitorNameField = find.byKey(ValueKey("visitorNameField"));
    final registerVisitButton = find.byKey(ValueKey("registerVisitButton"));


    await tester.pumpWidget(MaterialApp(home: Body()));
    await tester.enterText(visitorNameField, "Juan Perez");
    await tester.tap(registerVisitButton);
    await tester.pump(Duration(seconds: 10));   
    expect(find.text("Enviar código QR al visitante"), findsOneWidget);
  });


// testWidgets('CupertinoDatePicker selected time test', (WidgetTester tester) async {
//     DateTime selectedDateTime;

//     await tester.pumpWidget(MaterialApp(home: Body())
//     );

//     // Toca el widget para abrir el selector de fecha y hora
//     await tester.tap(find.byType(CupertinoDatePicker));

//     // Espera a que se muestre el selector de fecha y hora
//     await tester.pumpAndSettle();

//     // Selecciona la hora 13:45
//     await tester.dragUntilVisible(
//       find.text('1'), // Encuentra el número 1 en el selector de horas
//       find.byType(CupertinoPicker),
//       const Offset(0, -300),
//     );

//     await tester.dragUntilVisible(
//       find.text('45'), // Encuentra el número 45 en el selector de minutos
//       find.byType(CupertinoPicker),
//       const Offset(0, -100),
//     );

//     // Asegura que se haya seleccionado la hora 13:45
//     expect(selectedDateTime.hour, 13);
//     expect(selectedDateTime.minute, 45);
//   });
// }
    
}