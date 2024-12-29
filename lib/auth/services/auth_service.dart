import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:MamaCare/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class AuthService {
  final String baseUrl =
      'https://mamacare-api-447228900001.asia-southeast2.run.app/api/auth';

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
        return 'Register berhasil';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      
      // Kembalikan map yang berisi user dan token
      return {
        'user': UserModel.fromJson(data['data']),
        'token': data['token']
      };
    } else {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      print('Error: ${errorResponse['error']}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

  Future<Map<String, dynamic>> updateUserProfile({
    required String name,
    required String email,
    String? password,
    required File? profilePicture,
    required String token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/edit-profile');
      final request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $token';

      if (name.isNotEmpty) request.fields['name'] = name;
      if (email.isNotEmpty) request.fields['email'] = email;
      if (password != null && password.isNotEmpty) {
        request.fields['password'] = password;
      }

      if (profilePicture != null) {
        // Tambahkan logging
        print('File path: ${profilePicture.path}');
        final mimeType = lookupMimeType(profilePicture.path);
        print('Detected MIME type: $mimeType');

        if (mimeType != null && mimeType.startsWith('image/')) {
          final file = await http.MultipartFile.fromPath(
            'profilePicture',
            profilePicture.path,
            contentType:
                MediaType.parse(mimeType), // Tambahkan content type explicit
          );
          request.files.add(file);
        } else {
          return {
            'status': 'error',
            'message': 'Invalid file type. Please select an image file.'
          };
        }
      }

      // Tambahkan logging untuk request
      print('Request headers: ${request.headers}');
      print('Request fields: ${request.fields}');

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print('Response status code: ${response.statusCode}');
      print('Response body: $responseData');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(responseData);
        return {
          'status': 'success',
          'message': 'Profile updated successfully',
          'data': data
        };
      } else {
        final Map<String, dynamic> errorData = jsonDecode(responseData);
        return {
          'status': 'error',
          'message': errorData['error'] ?? 'Unknown error'
        };
      }
    } catch (e) {
      print('Error in updateUserProfile: $e');
      return {'status': 'error', 'message': e.toString()};
    }
  }
}
