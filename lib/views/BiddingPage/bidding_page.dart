import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/globals/variables.dart';
import 'package:minor_project/views/HomePage/home_page.dart';

class BiddingPage extends StatefulWidget {
  const BiddingPage({super.key});

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  int currentHighestBid = 15000; // Starting highest bid
  final TextEditingController bidController = TextEditingController();
  bool canSave = false;

  // Function to handle bidding logic
  void placeBid() {
    canSave = true;
    setState(() {
      userBid = int.tryParse(bidController.text) ?? 0;
      if (userBid > currentHighestBid) {
        currentHighestBid =
            userBid; // Updates the  highest bid if user bid is higher
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.green.shade50,
              title: const Text(
                "Success",
              ),
              content: Text(
                "Your bid of ₹$userBid has been placed!",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Flexify.back();
                  },
                  child: const Text(
                    "OK",
                  ),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.red.shade50,
              title: const Text(
                "Warning",
              ),
              content: Text(
                "This lot already has ₹$currentHighestBid amount bidded on it.Try another larger amount to win this.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Flexify.back();
                  },
                  child: const Text(
                    "OK",
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Place Your Bid',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Flexify.back();
          },
        ),
        actions: [
          Visibility(
            visible: canSave,
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green.shade100,
                    content: Text(
                      "Your BID amount is saved",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
                Flexify.goRemoveAll(
                  const HomePage(),
                  animation: FlexifyRouteAnimations.blur,
                  duration: Durations.medium1,
                );
              },
              icon: Icon(
                Icons.save,
                size: 30.w,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Highest Bid Display
            Text(
              "Current Highest Bid: ₹$currentHighestBid",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Enter Your Bid:",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              controller: bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter bid amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Submit Button
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: placeBid,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Submit My Bid",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
