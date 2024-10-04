import 'dart:async';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/views/RegisterPage/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progressValue = 0.0; // Initialize progress value
  late Timer timer; // Timer to increment progress

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  void startProgress() {
    // Timer that increases progressValue every 100ms
    timer = Timer.periodic(
        const Duration(
          milliseconds: 100,
        ), (timer) {
      if (progressValue < 1.0) {
        setState(() {
          progressValue += 0.02; // Increase progress value
        });
      } else {
        timer.cancel(); // Stop the timer when progress reaches 100%
        navigateToNextPage(); // Navigate when progress completes
      }
    });
  }

  void navigateToNextPage() {
    Flexify.goRemoveAll(
      const RegisterPage(),
      animation: FlexifyRouteAnimations.blur,
      duration: const Duration(
        milliseconds: 2000,
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.blue[200],
        child: Column(
          children: [
            SizedBox(
              height: 130.h,
            ),
            Image.asset(
              "lib/views/SplashScreen/assets/App_Logo.png",
            ),
            SizedBox(
              height: 225.h,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(20),
                backgroundColor: Colors.white,
                value: progressValue, // Set progress value here
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
