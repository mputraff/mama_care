import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://mama-care-api-backend.vercel.app/api/auth';

  Future<String> registerUser(
      String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return 'User registered successfully';
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        return 'Error: ${errorResponse['message'] ?? 'Failed to register'}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return 'User logged in successfully';
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        return 'Error: ${errorResponse['message'] ?? 'Failed to log in'}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
