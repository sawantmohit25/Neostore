import 'package:flutter/material.dart';
import 'package:neostore_app/Screens/login.dart';
import 'package:device_preview/device_preview.dart';
void main() {
  runApp(MaterialApp(
    home:LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
// void main() => runApp(
//   DevicePreview(
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp( // Add the builder here
//       home: LoginScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

