import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart'; // Import the toastification package
import 'package:minor_project/views/HomePage/home_page.dart';

class BiddingPage extends StatefulWidget {
  const BiddingPage({super.key});

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  int currentHighestBid = 15000; // Starting highest bid
  int userBid = 0; // Track user bid
  final TextEditingController bidController = TextEditingController();
  bool canSave = false; // Show/hide save button
  bool isBiddingActive = false; // Control the active state of bidding

  // Timer-related variables
  Timer? biddingTimer;
  int biddingDuration = 60; // Duration in seconds
  String formattedTime = "00:01:00"; // Initial formatted time

  @override
  void initState() {
    super.initState();
    updateFormattedTime(); // Set initial formatted time
  }

  // Function to start the bidding timer
  void startBiddingTimer() {
    biddingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (biddingDuration > 0) {
        setState(() {
          biddingDuration--; // Decrease duration every second
          updateFormattedTime(); // Update formatted time in the UI
        });
      } else {
        // Timer ends, cancel the timer
        timer.cancel();
        setState(() {
          isBiddingActive = false; // Bidding period has ended
        });
        showWinnerDialog(); // Show dialog for the winner
      }
    });
  }

  // Function to update the formatted time display
  void updateFormattedTime() {
    final duration = Duration(seconds: biddingDuration);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    formattedTime = "00:$minutes:$seconds"; // Set time in mm:ss format
  }

  // Function to handle bidding logic
  void placeBid() {
    if (!isBiddingActive) {
      // Show an error if bidding has ended
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red.shade50,
            title: const Text("Bidding Closed"),
            content: const Text(
              "The bidding period has ended. You cannot place any more bids.",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
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
      return; // Early return if bidding is closed
    }

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
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "OK",
                ),
              ),
            ],
          );
        },
      );
      return; // Early return if bid is empty
    }

    setState(() {
      userBid = int.tryParse(bidController.text) ?? 0;

      if (userBid > currentHighestBid) {
        // Successful bid
        currentHighestBid = userBid;
        canSave = true; // Show save button

        // Start the bidding timer if it hasn't started
        if (!isBiddingActive) {
          isBiddingActive = true;
          startBiddingTimer();
        }

        // Display success toast
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text(
            "Success",
          ),
          description: Text(
            "Your bid of ₹$userBid has been placed!",
          ),
          backgroundColor: Colors.greenAccent.shade100,
          autoCloseDuration: const Duration(seconds: 5),
        );
      } else if (userBid == currentHighestBid) {
        // Display warning for same bid amount
        toastification.show(
          context: context,
          type: ToastificationType.warning,
          title: const Text("Same Bid Amount"),
          description: Text(
              "Your bid of ₹$userBid is equal to the current highest bid. Try bidding a higher amount to win this lot.,"),
          backgroundColor: Colors.orangeAccent.shade100,
          autoCloseDuration: const Duration(seconds: 5),
        );
        canSave = false; // Hide save button
      } else {
        // Display error for lower bid
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: const Text(
            "Warning",
          ),
          description: Text(
            "This lot already has ₹$currentHighestBid amount bidded on it. Try another larger amount to win this.",
          ),
          backgroundColor: Colors.redAccent.shade100,
          autoCloseDuration: const Duration(seconds: 5),
        );
        canSave = false; // Hide save button
      }
    });
  }

  // Function to display the winner once bidding ends
  void showWinnerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade50,
          title: const Text(
            "Bidding Ended",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "The bidding has ended. The highest bid was ₹$currentHighestBid. Congratulations to the highest bidder!",
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Flexify.goRemoveAll(const HomePage()); // Navigate to homepage
              },
              child: const Text(
                "OK",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    bidController.dispose();
    biddingTimer?.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Place Your Bid'),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Flexify.back(),
        ),
        actions: [
          Visibility(
            visible: canSave,
            child: IconButton(
              onPressed: () {
                // Show success toast when the bid is saved
                toastification.show(
                  context: context,
                  type: ToastificationType.success,
                  title: const Text(
                    'Bid Saved',
                  ),
                  description: const Text(
                    'Your bid has been saved successfully.',
                  ),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  autoCloseDuration: const Duration(
                    seconds: 5,
                  ),
                );
                Flexify.goRemoveAll(
                  const HomePage(),
                ); // Navigate to homepage
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Countdown Timer Display
            Text(
              "Time Remaining:",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              formattedTime, // Display formatted time
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20.h),
            // Current Highest Bid Display
            Text(
              "Current Highest Bid: ₹$currentHighestBid",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.h),
            // Enter Bid
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
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white70,
                hintText: "Enter bid amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: placeBid,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Submit My Bid",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
