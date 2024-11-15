import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_oauth/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final _googleSignIn = GoogleSignIn();

  static Future<dynamic> login(String email, String password) async {
    print("Attempting email login...");
    final response = await http.post(
      Uri.parse('$BASE_URL/login'),
      body: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<dynamic> signup(String email, String password) async {
    print("Attempting signup...");
    final response = await http.post(
      Uri.parse('$BASE_URL/signup'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print("Error: ${response.body}");
      return null;
    }
  }

  static Future<GoogleSignInAccount?> googleLogin() => _googleSignIn.signIn();
  static Future logout() => _googleSignIn.disconnect();
}
