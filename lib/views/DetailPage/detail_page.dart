import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/views/BiddingPage/bidding_page.dart';

class DetailPage extends StatelessWidget {
  final String artName;
  final String painter;
  final String imageUrl;
  final String description;
  final double minBidPrice;

  const DetailPage({
    super.key,
    required this.artName,
    required this.painter,
    required this.imageUrl,
    required this.description,
    required this.minBidPrice,
  });

  void _onPlaceYourBidButtonPressed() {
    // Assuming you have access to these values:
    String artName = this.artName;
    String imageUrl = this.imageUrl;
    int currentHighestBid = minBidPrice.toInt();

    Flexify.go(
      BiddingPage(
        artName: artName,
        imageUrl: imageUrl,
        currentHighestBid: currentHighestBid,
      ),
      animation: FlexifyRouteAnimations.blur,
      animationDuration: Durations.medium1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Flexify.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text(
          artName,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Container for details
          Container(
            height: 600.h,
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Art Image Container
                Container(
                  height: 250.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Art Name and Painter
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Art Name: ",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            TextSpan(
                              text: artName, // Value text
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Value color
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Painter: ",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            TextSpan(
                              text: painter, // Value text
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70, // Value color
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Art Description
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Description: ",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            TextSpan(
                              text: description,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white70,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Minimum Bid Amount
                      Text(
                        "Minimum Bid: \$${minBidPrice.toString()}",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // BID Button at the bottom
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              width: double.infinity,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  Flexify.go(
                    BiddingPage(
                      artName: artName,
                      imageUrl: imageUrl,
                      currentHighestBid: minBidPrice.toInt(),
                    ),
                    animation: FlexifyRouteAnimations.blur,
                    animationDuration: Durations.medium1,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "PLACE YOUR BID",
                  style: TextStyle(
                    fontSize: 20.sp,
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
