import 'package:flutter/material.dart';
import 'package:flutter_application_1/Onboboarding/home.dart';
import 'package:flutter_application_1/Onboboarding/onboarding_view.dart';
// import 'package:flutter_application_1/Onboboarding/onbording_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;
  runApp(MyApp(onboarding: onboarding));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onboarding ? Home() : OnboardingView(),
    );
  }
}
