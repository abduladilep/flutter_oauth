import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_oauth/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final _googleSignIn = GoogleSignIn();

  static const String _jwtTokenKey = 'jwt_token';
  static const String _googleUserKey = 'google_user';
    static const String _isGoogleLoginKey = 'is_google_login';


  static Future<dynamic> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      await _saveJwtToken(token);

      return data;
    } else {
      return null;
    }
  }

  static Future<dynamic> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/signup'),
      body: {'email': email, 'password': password},
    );
    print(response);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      await _saveJwtToken(token);

      return data;
    } else {
      return null;
    }
  }

  static Future<GoogleSignInAccount?> googleLogin() async {
    final account = await _googleSignIn.signIn();
    print(account);
    if (account != null) {
      await _saveGoogleUser({
        'name': account.displayName,
        'email': account.email,
        'photoUrl': account.photoUrl,
      });
    }

    return account;
  }

  static Future<void> _saveJwtToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jwtTokenKey, token);
  }

  static Future<String?> getJwtToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_jwtTokenKey);
  }

  static Future<void> _saveGoogleUser(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_googleUserKey, jsonEncode(userData));
        await prefs.setBool(_isGoogleLoginKey, true); // Mark as Google login

  }

  static Future<Map<String, dynamic>?> getGoogleUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString(_googleUserKey);

    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  static Future<void> _clearPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> logout(BuildContext context, {bool isGoogleLogin = false}) async {
    await _clearPreferences();

    if (isGoogleLogin) {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect(); 
    }

  }

}





