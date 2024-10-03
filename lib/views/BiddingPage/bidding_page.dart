import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/globals/bids_placed_list.dart';
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
    if (bidController.text.isEmpty) {
      // Show an error message if the bid amount is empty
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red.shade50,
            title: const Text(
              "Error",
            ),
            content: const Text(
              "Please enter a bid amount before submitting.",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        userBid = int.tryParse(bidController.text) ?? 0;

        if (userBid > currentHighestBid) {
          // Successful bid
          currentHighestBid = userBid;
          canSave = true; // Show save button

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
          bidsPlacedList.add(userBid);
        } else if (userBid == currentHighestBid) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.yellow.shade50,
                title: const Text(
                  "SAME BID AMOUNT",
                ),
                content: Text(
                  "Your bid of ₹$userBid is equal to the current highest bid. Try bidding a higher amount to win this lot.",
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
          canSave = false; // Hide save button
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
                  "This lot already has ₹$currentHighestBid amount bidded on it. Try another larger amount to win this.",
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
          canSave = false; // Hide save button
        }
      });
    }
  }

  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Place Your Bid',
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Art Image (Consistent with Detail Page)
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/Famous/Image4.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Current Highest Bid Display
            Text(
              "Current Highest Bid:",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "\$$currentHighestBid",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Enter Your Bid:",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              controller: bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white70,
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
                height: 60.h,
                child: ElevatedButton(
                  onPressed: placeBid,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Submit My Bid",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
