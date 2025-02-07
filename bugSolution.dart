```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData['key']);
    } else {
      //More specific error handling based on HTTP status code
      throw HttpException('Failed to load data: ${response.statusCode}, ${response.reasonPhrase}');
    }
  } on SocketException catch (e) {
    print('SocketException: $e'); // Handle network errors
  } on FormatException catch (e) {
    print('FormatException: $e');// Handle JSON decoding errors
  } on HttpException catch (e) {
    print('HTTP Exception: $e');
  } catch (e) {
    //Handle any other unexpected exception
    print('An unexpected error occurred: $e');
    //Consider using a logging library for more sophisticated logging in production
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() => message;
}
```