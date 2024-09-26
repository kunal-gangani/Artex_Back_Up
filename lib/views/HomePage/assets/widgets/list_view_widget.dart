import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SizedBox listViewWidget() {
  return SizedBox(
    height: 200.h,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (
        context,
        index,
      ) {
       return listViewWidget();
      },
    ),
  );
}
