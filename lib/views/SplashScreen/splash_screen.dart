import 'dart:async';
import 'dart:developer';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/helper/auth_helper.dart';
import 'package:minor_project/views/HomePage/home_page.dart';
import 'package:minor_project/views/RegisterPage/register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(
        seconds: 5,
      ),
      () {
        log("Current User : ${AuthHelper.authHelper.auth.currentUser}");
        if (AuthHelper.authHelper.auth.currentUser != null) {
          Flexify.goRemoveAll(
            const HomePage(),
            animation: FlexifyRouteAnimations.blur,
            duration: const Duration(
              milliseconds: 2000,
            ),
          );
        } else {
          Flexify.goRemoveAll(
            const RegisterPage(),
            animation: FlexifyRouteAnimations.blur,
            duration: const Duration(
              milliseconds: 2000,
            ),
          );
        }
      },
    );
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
                // value: progressValue, // Set progress value here
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
