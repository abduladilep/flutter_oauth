import 'package:flutter/material.dart';
import 'package:flutter_oauth/services/authservice.dart';
import 'package:flutter_oauth/screens/signin-screen.dart';
import 'package:flutter_oauth/widgets/costom-button.dart';
import 'package:flutter_oauth/screens/homescreen.dart'; // Add this import
// import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign-In package

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _googleLogin() async {
    setState(() {
      _isLoading = true;
    });

    final response = await AuthService.googleLogin();

    print(response);
    setState(() {
      _isLoading = false;
    });

    if (response != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google login failed. Please try again.')),
      );
    }
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await AuthService.login(email, password);
    print(response);
    setState(() {
      _isLoading = false;
    });

    if (response != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homeScreen()),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid login credentials. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Password TextField
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      // Regular Login Button
                      CustomButton(text: 'Login', onPressed: _login),
                      SizedBox(height: 10),
                      // Google Login Button
                      ElevatedButton.icon(
                        onPressed: _googleLogin,

                        // Call the Google login method
                        icon: Icon(Icons.login),
                        label: Text('Login with Google'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black, // Text color
                          backgroundColor: Colors.white, // Button color
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 20),
            // Navigate to Signup screen
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
