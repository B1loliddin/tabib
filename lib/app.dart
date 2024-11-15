import 'package:flutter/material.dart';
import 'package:tabib/pages/auth/height_weight_gender_page.dart';
import 'package:tabib/pages/auth/otp_verification_page.dart';
import 'package:tabib/pages/auth/sign_in_page.dart';
import 'package:tabib/pages/auth/sign_up_page.dart';
import 'package:tabib/pages/auth/splash_page.dart';

class Tabib extends StatelessWidget {
  const Tabib({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'height_weight_gender',
      routes: {
        // '/': (context) => SplashPage(),
        'sign_up_page': (context) => SignUpPage(),
        'sign_in_page': (context) => SignInPage(),
        'otp_verification_page': (context) => OtpVerificationPage(email: ''),
        'height_weight_gender': (context) => HeightWeightGenderPage(),
      },
    );
  }
}
