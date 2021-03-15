import 'package:flutter/material.dart';
import 'package:neostore_app/Screens/login.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:neostore_app/Screens/home_screen.dart';
import 'package:neostore_app/screens/reset_password.dart';

import 'Screens/splash_screen.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// class Splash2 extends StatelessWidget {
//   Color myHexColor1 = Color(0xfffe3f3f);
//   Color myHexColor = Color(0xffe91c1a);
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       backgroundColor:myHexColor ,
//       seconds: 4,
//       navigateAfterSeconds:LoginScreen(),
//       title:Text('NeoSTORE',textScaleFactor: 2,style: TextStyle(color: Colors.white,fontSize:28),),
//       // image:Image.network('https://media-exp1.licdn.com/dms/image/C510BAQGeA0DMh9D5_w/company-logo_200_200/0/1537521361668?e=2159024400&v=beta&t=qoydj6ux2KL2cgzToGPbP-J9Qc0tX-0gJyXNKkk1P2w'),
//       loadingText: Text("Loading",style: TextStyle(color: Colors.white),),
//       photoSize: 100.0,
//       loaderColor: Colors.white,
//     );
//   }
// }
// void main() => runApp(
//   DevicePreview(
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );
//

