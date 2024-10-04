import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/views/HomePage/home_page.dart';
import 'package:toastification/toastification.dart';
import 'package:minor_project/globals/bids_placed_list.dart';

class BiddingPage extends StatefulWidget {
  final String artName;
  final String imageUrl;
  final int currentHighestBid;

  const BiddingPage({
    super.key,
    required this.artName,
    required this.imageUrl,
    required this.currentHighestBid,
  });

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  int userBid = 0; // Track user bid
  final TextEditingController bidController = TextEditingController();
  bool canSave = false; // Show/hide save button
  bool bidSubmitted = false; // Track if bid is submitted

  @override
  void initState() {
    super.initState();
  }

  // Function to handle bidding logic and send data to global bidsPlacedList
  void placeBid() {
    if (bidController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red.shade50,
            title: const Text("Error"),
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
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      userBid = int.tryParse(bidController.text) ?? 0;

      String bidStatus = 'unconfirmed';

      if (userBid > widget.currentHighestBid) {
        canSave = true;
        bidSubmitted = true;

        bidStatus = 'unconfirmed';

        // Add to global list with bidStatus
        bidsPlacedList.add({
          'artName': widget.artName,
          'bidAmount': userBid,
          'wonBid': false,
          'bidStatus': bidStatus, // New field for bid status
          'date': DateTime.now().toString(),
          'imageUrl': widget.imageUrl,
        });

        // Display success toast
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text("Success"),
          description: Text("Your bid of ₹$userBid has been placed!"),
          backgroundColor: Colors.greenAccent.shade100,
          autoCloseDuration: const Duration(seconds: 5),
        );

        // Start a timer for 2 minutes to check if the user still has the highest bid
        Timer(const Duration(minutes: 2), () {
          if (bidSubmitted && userBid > widget.currentHighestBid) {
            // Update bid status in bidsPlacedList
            setState(() {
              bidsPlacedList.last['wonBid'] = true;
              bidsPlacedList.last['bidStatus'] = 'success';
            });
            // Show winning message
            showWinningDialog();
          } else {
            // If the bid is lost, update the status to 'loss'
            setState(() {
              bidsPlacedList.last['bidStatus'] = 'loss';
            });
          }
        });

        // Navigate back to the HomePage after placing the bid
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else if (userBid == widget.currentHighestBid) {
        toastification.show(
          context: context,
          type: ToastificationType.warning,
          title: const Text("Same Bid Amount"),
          description: Text(
            "Your bid of ₹$userBid is equal to the current highest bid. Try bidding a higher amount to win this lot.",
          ),
          backgroundColor: Colors.orangeAccent.shade100,
          autoCloseDuration: const Duration(seconds: 5),
        );
        canSave = false;
      } else {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: const Text("Warning"),
          description: Text(
            "This lot already has ₹${widget.currentHighestBid} amount bidded on it. Try another larger amount to win this.",
          ),
          backgroundColor: Colors.redAccent.shade100,
          autoCloseDuration: const Duration(seconds: 5),
        );
        canSave = false;
      }
    });
  }

  // Function to display the winning message
  void showWinningDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade50,
          title: const Text(
            "Congratulations!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "You have won the bid with an amount of ₹$userBid!",
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(widget.artName),
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
                toastification.show(
                  context: context,
                  type: ToastificationType.success,
                  title: const Text('Bid Saved'),
                  description:
                      const Text('Your bid has been saved successfully.'),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  autoCloseDuration: const Duration(seconds: 5),
                );
                Flexify.goRemoveAll(const HomePage());
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              "Current Highest Bid: ₹${widget.currentHighestBid}",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.h),
            // Bid Input Field
            TextField(
              controller: bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Your Bid Amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: placeBid,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    maximumSize: Size(150.w, 45.h),
                  ),
                  child: const Text(
                    "Place Bid",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
