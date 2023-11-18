
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../../layout/social_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/splash_screen.jpg',fit: BoxFit.fill,),
      nextScreen:  SocialLayout(),
      splashIconSize: size.width *.9,
      backgroundColor: const Color(0xFF003758),
      splashTransition:SplashTransition.scaleTransition,
    );
  }
}
