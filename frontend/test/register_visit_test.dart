// import 'package:mocktail/mocktail.dart';
// import 'package:test/test.dart';
// import 'package:http/http.dart' as http;
// import 'package:safecitadel/utils/Authorization.dart';

// class MockHttpClient extends Mock implements http.Client {}

// void main() {
//   late ApiClient apiClient;
//   late MockHttpClient mockHttpClient;

//   setUp(() {
//     mockHttpClient = MockHttpClient();
//     apiClient = ApiClient();
//     apiClient.client = mockHttpClient; // Asegúrate de que tu 
//   });

//   // ... (Tus pruebas de getVisits)

//   test('getTokenAndPostVisit should return a valid QR ID when API call is successful', () async {
//     final mockResponse = http.Response('{"qr_id": "valid_qr_id"}', 200);
//     final expectedResponse = "valid_qr_id";

//     when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
//         .thenAnswer((_) async => mockResponse);

//     // Simulamos la entrada de usuario
//     nombreVisitacontroller.text = "Test Visit";
//     final result = await getTokenAndPostVisit(null); // Puedes enviar null o un mock de BuildContext

//     expect(result, equals(expectedResponse));
//     verify(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')));
//   });

//   test('getTokenAndPostVisit throws exception on error response', () async {
//     final mockResponse = http.Response('Error', 400);

//     when(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')))
//         .thenAnswer((_) async => mockResponse);

//     expect(() => getTokenAndPostVisit(null), throwsException);
//     verify(() => mockHttpClient.post(any(), headers: any(named: 'headers'), body: any(named: 'body')));
//   });
// }
// ``
