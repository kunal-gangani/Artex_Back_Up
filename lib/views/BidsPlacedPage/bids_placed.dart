import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/globals/bids_placed_list.dart';

class BidsPlacedPage extends StatefulWidget {
  const BidsPlacedPage({super.key});

  @override
  State<BidsPlacedPage> createState() => _BidsPlacedPageState();
}

class _BidsPlacedPageState extends State<BidsPlacedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bids Placed",
        ),
        backgroundColor: Colors.blue.shade200,
      ),
      body: bidsPlacedList.isNotEmpty
          ? ListView.builder(
              itemCount: bidsPlacedList.length,
              itemBuilder: (context, index) {
                final bid = bidsPlacedList[
                    index]; // Assuming each bid is an object with required properties
                return Card(
                  color: Colors.grey[100],
                  margin: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 15.w,
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bid Amount: ₹{bid['amount']}", // Replace 'amount' with your bid amount key
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Item: {bid['item']}", // Replace 'item' with your item name key
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Placed On: {bid['date']}", // Replace 'date' with your date key
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "No bids placed yet.",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
    );
  }
}
