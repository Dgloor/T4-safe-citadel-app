import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import '../lib/utils/Authorization.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiClient apiClient;
  late MockHttpClient mockHttpClient;
 setUp(() {
    mockHttpClient = MockHttpClient();
    apiClient = ApiClient();
  });
 test('getVisits returns decoded response on successful request', () async {
    final mockResponse = http.Response('{"key": "value"}', 200);
    final expectedResponse = {"key": "value"};

    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => mockResponse);

    final result = await apiClient.getVisits();

    expect(result, equals(expectedResponse));
    verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')));
  });

 test('getVisits throws exception on error response', () async {
    final mockResponse = http.Response('Error', 400);

    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => mockResponse);

    expect(() => apiClient.getVisits(), throwsException);
    verify(() => mockHttpClient.get(any(), headers: any(named: 'headers')));
  });
}