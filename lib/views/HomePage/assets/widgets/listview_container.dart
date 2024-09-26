import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/views/DetailPage/detail_page.dart';

GestureDetector listViewContainer({
  required String thumbnail,
  required String painting,
  required int price,
}) {
  return GestureDetector(
    onTap: () {
      Flexify.go(
        const DetailPage(),
        animation: FlexifyRouteAnimations.blur,
        animationDuration: Durations.medium1,
      );
    },
    child: Container(
      width: 170.w,
      padding: EdgeInsets.all(
        14.w,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1.5,
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.05,
            ),
            offset: const Offset(
              0,
              4,
            ),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      thumbnail,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  painting,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${price.toString()}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
