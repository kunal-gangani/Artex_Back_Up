import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:minor_project/views/BidsPlacedPage/bids_placed.dart';
import 'package:minor_project/model/house_holds_data_model.dart';
import 'package:minor_project/globals/art_data.dart';
import 'package:minor_project/model/hots_data_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/views/ReviewsPage/reviews_page.dart';
import 'package:minor_project/views/UserProfilePage/user_profile_page.dart';

import '../assets/widgets/listview_container.dart';

class HomePageComponent extends StatefulWidget {
  const HomePageComponent({super.key});

  @override
  State<HomePageComponent> createState() => _HomePageComponentState();
}

class _HomePageComponentState extends State<HomePageComponent> {
  final List<String> imageList = [
    'lib/views/HomePage/assets/carousel_images/image1.jpg',
    'lib/views/HomePage/assets/carousel_images/image2.jpg',
    'lib/views/HomePage/assets/carousel_images/image3.jpg',
    'lib/views/HomePage/assets/carousel_images/image4.jpg',
    'lib/views/HomePage/assets/carousel_images/image5.jpg',
  ];
  int _currentCarouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: imageList.length,
              itemBuilder: (
                context,
                index,
                realIndex,
              ) {
                return AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8.0,
                        spreadRadius: 3.0,
                        offset: const Offset(
                          0,
                          4,
                        ),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        imageList[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 20,
                      //   left: 20,
                      //   child: Text(
                      //     'Image ${index + 1}',
                      //     style: const TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: 250.h,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(
                  milliseconds: 1200,
                ),
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                scrollPhysics: const BouncingScrollPhysics(),
                onPageChanged: (
                  index,
                  reason,
                ) {
                  setState(() {
                    _currentCarouselIndex = index;
                  });
                },
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Hots Right Now",
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 210.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: artHotsList.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  HotsDataModel item = hots[index];
                  return hotListViewContainer(
                    e: item,
                    setState: () {
                      setState(() {});
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Most Picked Arts",
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 210.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: artFamousList.length,
                itemBuilder: (context, index) {
                  final item = famous[index];
                  return famousListViewContainer(
                      e: item,
                      setState: () {
                        setState(() {});
                      });
                },
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Suitable for House-holds",
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 210.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: artHouseHoldsList.length,
                itemBuilder: (
                  context,
                  index,
                ) {
                  HouseHoldsDataModel item = households[index];
                  return houseListViewContainer(
                    e: item,
                    setState: () {
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
