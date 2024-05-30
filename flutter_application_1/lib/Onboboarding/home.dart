import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: () {
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setBool('onboarding', false);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OnboardingView()));
        },
        child: Text('Enable onboard'),
      )),
    );
  }
}
