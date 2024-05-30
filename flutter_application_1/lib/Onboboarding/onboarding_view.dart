import 'package:flutter/material.dart';
import 'package:flutter_application_1/Onboboarding/home.dart';
import 'package:flutter_application_1/Onboboarding/onbording_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Component/color.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnbordingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: Text('Skip')),
                  // indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: Duration(microseconds: 600),
                        curve: Curves.easeIn),
                    effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: Colors.purple),
                  ),

                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: Duration(seconds: 1), curve: Curves.easeIn),
                      child: Text('next')),
                ],
              ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].description,
                  style: const TextStyle(color: Colors.grey, fontSize: 17),
                  textAlign: TextAlign.center,
                )
              ],
            );
          },
        ),
      ),
    );
  }
  //get started button

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: primaryColor),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool('onboarding', true);

          if (!mounted) return;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Text(
          'Get started',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
