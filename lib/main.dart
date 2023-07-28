import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:stockapps/widget/bottom_navbar_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        navigateAfterSeconds: BottomNavbar(),
        seconds: 1,
        backgroundColor: Colors.white,
        image: Image.asset('assets/images/logo.png'),
        photoSize: 150.0,
        loaderColor: Colors.black54,
      ),
    );
  }
}
