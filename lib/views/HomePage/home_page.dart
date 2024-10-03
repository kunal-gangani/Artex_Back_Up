import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/globals/art_data.dart';
import 'package:minor_project/model/hots_data_model.dart';
import 'package:minor_project/model/house_holds_data_model.dart';
import 'package:minor_project/views/BidsPlacedPage/bids_placed.dart';
import 'package:minor_project/views/FavourtiesPage/favourites_page.dart';
import 'package:minor_project/views/HomePage/assets/widgets/listview_container.dart';
import 'package:minor_project/views/ReviewsPage/reviews_page.dart';
import 'package:minor_project/views/UserProfilePage/user_profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBottomNavIndex = 0;
  int _currentCarouselIndex = 0;

  final List<String> imageList = [
    'lib/views/HomePage/assets/carousel_images/image1.jpg',
    'lib/views/HomePage/assets/carousel_images/image2.jpg',
    'lib/views/HomePage/assets/carousel_images/image3.jpg',
    'lib/views/HomePage/assets/carousel_images/image4.jpg',
    'lib/views/HomePage/assets/carousel_images/image5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Welcome Art Aficionado",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Flexify.go(
                const FavouritesPage(),
                animation: FlexifyRouteAnimations.blur,
                animationDuration: Durations.medium1,
              );
            },
            icon: Icon(
              Icons.favorite_border_outlined,
              size: 32.w,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          imageList[index],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
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
                  itemBuilder: (context, index) {
                    HotsDataModel item = hots[index];
                    return hotListViewContainer(
                      e: item,
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
                    );
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
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Flexify.go(
                        const BidsPlacedPage(),
                        animation: FlexifyRouteAnimations.blur,
                        animationDuration: Durations.medium1,
                      );
                    },
                    child: const Text(
                      "Button",
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Flexify.go(
                        const ReviewsPage(),
                        animation: FlexifyRouteAnimations.blur,
                        animationDuration: Durations.medium1,
                      );
                    },
                    child: const Text(
                      "Button",
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Flexify.go(
                        const UserProfilePage(),
                        animation: FlexifyRouteAnimations.blur,
                        animationDuration: Durations.medium1,
                      );
                    },
                    child: const Text(
                      "Button",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: _currentBottomNavIndex,
          onTap: (index) {
            setState(() {
              _currentBottomNavIndex = index;
            });
          },
          items: [
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.home,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectedColor: Colors.blue,
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.gavel,
              ),
              selectedColor: Colors.green,
              title: Text(
                "Bids",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SalomonBottomBarItem(
              selectedColor: Colors.red,
              icon: const Icon(
                Icons.reviews,
              ),
              title: Text(
                "Insights",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SalomonBottomBarItem(
              selectedColor: Colors.orange,
              icon: const Icon(
                Icons.person,
              ),
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
