import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/views/BiddingPage/bidding_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Flexify.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        backgroundColor: Colors.blue.shade200,
        title: const Text(
          "Mona Lisa",
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color(0xff654321),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: const EdgeInsets.all(
                      10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Art Name",
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Painter Name",
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Small description",
                          style: TextStyle(
                            fontSize: 17.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Minimum Bid : ₹15,000",
                          style: TextStyle(
                            fontSize: 17.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  // Action when the BID button is clicked
                  Flexify.go(
                    const BiddingPage(),
                    animation: FlexifyRouteAnimations.blur,
                    animationDuration: Durations.medium1,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "BID",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
