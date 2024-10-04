import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/helper/auth_helper.dart';
import 'package:minor_project/views/HomePage/home_page.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber; // Add phoneNumber field
  final String countryCode; // Add countryCode field

  const OTPVerificationPage({
    super.key,
    required this.phoneNumber,
    required this.countryCode,
  });

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();String otp = "";

  // Method to validate OTP
  void _verifyOTP() async{
    if (_formKey.currentState?.validate() == true) {
      // Here, you can use widget.phoneNumber and widget.countryCode as needed
      Map<String, dynamic> res =
          await AuthHelper.authHelper.checkMyOTP(otp: otp);

      if (res['user'] != null) {
        SnackBar snackBar = const SnackBar(
          content: Text("Otp Verification Successfully"),
          backgroundColor: Colors.green,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Flexify.goRemove(
          const HomePage(),
          animation: FlexifyRouteAnimations.blur,
          duration: Durations.medium1,
        );
      }

      if (res['error'] != null) {
        SnackBar snackBar = const SnackBar(
          content: Text("Otp Verification Unsuccessfully"),
          backgroundColor: Colors.red,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text(
      //       'OTP Verified!',
      //     ),
      //   ),
      // );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Invalid OTP, please try again',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "OTP Verification",
        ),
        backgroundColor: const Color(0xFFF8F8F8),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF8F8F8),
        ),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'You will receive a 6-digit OTP code for phone number verification',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.h,
                ),
                // Display the country code and phone number for confirmation
                Text(
                  'Country Code: ${widget.countryCode}, Phone Number: ${widget.phoneNumber}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Pinput(
                  controller: _otpController,
                  focusNode: _focusNode,
                  length: 6,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Please enter a valid 6-digit OTP';
                    }
                    return null;
                  },
                  showCursor: true,
                  // onCompleted: (otp) => _verifyOTP(),
                  pinAnimationType: PinAnimationType.fade,
                  onChanged: (value) {
                    // Handle OTP change if needed
                    otp = value;
                    setState(() {

                    });
                  },
                  focusedPinTheme: PinTheme(
                    height: 50,
                    width: 40,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  defaultPinTheme: PinTheme(
                    height: 70.h,
                    width: 60.w,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      color: Colors.blue.shade100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                  onPressed: _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007AFF),
                    padding: EdgeInsets.symmetric(
                      horizontal: 50.w,
                      vertical: 15.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
