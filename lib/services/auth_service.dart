import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';
  static const String apiAuthRegister = '/auth/register/';
  static const String apiAuthTokenCreate = '/auth/token/create/';
  static const String apiAuthActivateAccount = '/auth/activate-account/';

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final Uri url = Uri.parse('$baseUrl$apiAuthRegister');
      final body = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
      };

      final response = await http.post(url, body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Status Code:${response.statusCode}');
      } else {
        debugPrint('Status Code:${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Sign Up Error: $e');
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final Uri url = Uri.parse('$baseUrl$apiAuthTokenCreate');
      final body = {
        'email': email,
        'password': password,
      };

      final response = await http.post(url, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final prefs = await SharedPreferences.getInstance();
        // final String authToken = jsonDecode(response.body);
        //
        // await prefs.setString('auth_token', authToken);

        debugPrint('Auth Token: ${response.body}');
      } else {}
    } catch (e) {
      debugPrint('Sign In Error: $e');
    }
  }

  Future<void> verifyOtp(int activationCode, String email) async {
    try {
      final Uri url = Uri.parse('$baseUrl$apiAuthActivateAccount');
      final body = {
        'activation_code': activationCode,
        'email': email,
      };

      final response = await http.post(url, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {}
    } catch (e) {
      debugPrint('OTP Verification: $e');
    }
  }
}
