
import 'package:flutter/material.dart';
import 'package:flutter_oauth/services/authservice.dart';
import 'package:flutter_oauth/screens/login-screen.dart';

class homeScreen extends StatelessWidget {

  void _logout(BuildContext context) async {
    await AuthService.logout(context);

     Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the App!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
