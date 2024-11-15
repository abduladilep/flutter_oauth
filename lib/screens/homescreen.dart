// import 'package:flutter/material.dart';

// class homeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Welcome')),
//       body: Center(
//         child: Text(
//           'Welcome to the App!',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  // Function to handle logout action
  void _logout(BuildContext context) {
    // Perform logout logic here
    // For example, navigate back to the login screen or clear user session
    print('User logged out');
    
    // Optionally, navigate to a login screen (replace 'LoginScreen()' with your login screen)
    Navigator.pushReplacementNamed(context, '/login');
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
            SizedBox(height: 20), // Add spacing between text and button
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