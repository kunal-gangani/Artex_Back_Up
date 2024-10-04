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
      body: bidsPlacedList.isNotEmpty
          ? ListView.builder(
              itemCount: bidsPlacedList.length,
              itemBuilder: (context, index) {
                final bid = bidsPlacedList[index];
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
                          "Bid Amount: ₹${bid['bidAmount']}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Item: ${bid['artName']}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Placed On: ${bid['date']}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Image.asset(
                          bid['imageUrl'],
                          height: 150.h,
                          width: 150.w,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Status: ${bid['bidStatus']}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: bid['bidStatus'] == 'success'
                                ? Colors.green
                                : bid['bidStatus'] == 'loss'
                                    ? Colors.red
                                    : Colors.orange,
                            fontWeight: FontWeight.bold,
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
