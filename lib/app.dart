import 'package:flutter/material.dart';
import 'package:tabib/pages/all_pages.dart';
import 'package:tabib/pages/auth/height_weight_gender_page.dart';
import 'package:tabib/pages/auth/otp_verification_page.dart';
import 'package:tabib/pages/auth/sign_in_page.dart';
import 'package:tabib/pages/auth/sign_up_page.dart';
import 'package:tabib/pages/call_page.dart';
import 'package:tabib/pages/home_page.dart';
import 'package:tabib/pages/search_page.dart';

class Tabib extends StatelessWidget {
  const Tabib({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'all_pages',
      routes: {
        // '/': (context) => SplashPage(),
        'sign_up_page': (context) => const SignUpPage(),
        'sign_in_page': (context) => const SignInPage(),
        'otp_verification_page': (context) => const OtpVerificationPage(email: ''),
        'height_weight_gender': (context) => const HeightWeightGenderPage(),
        'all_pages': (context) => const AllPages(),
        'home_page': (context) => const HomePage(),
        'search_page': (context) => const SearchPage(),
        'call_page': (context) => const CallPage(),
      },
    );
  }
}
