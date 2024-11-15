// import 'package:flutter/material.dart';
// import 'screens/login-screen.dart';
// // import 'screens/signup_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Auth',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginScreen(), 
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'screens/login-screen.dart';
// import 'screens/signup_screen.dart';
void main() {
  runApp(const MyApp()); // Do not use 'const MyApp()'
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Do not use 'const MyApp();' here
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
