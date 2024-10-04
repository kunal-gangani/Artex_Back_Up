import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:minor_project/views/BidsPlacedPage/bids_placed.dart';
import 'package:minor_project/views/FavourtiesPage/favourites_page.dart';
import 'package:minor_project/views/HomePage/components/home_page.dart';
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

  final List<String> imageList = [
    'lib/views/HomePage/assets/carousel_images/image1.jpg',
    'lib/views/HomePage/assets/carousel_images/image2.jpg',
    'lib/views/HomePage/assets/carousel_images/image3.jpg',
    'lib/views/HomePage/assets/carousel_images/image4.jpg',
    'lib/views/HomePage/assets/carousel_images/image5.jpg',
  ];

  List allPages = [
    const HomePageComponent(),
    const BidsPlacedPage(),
    const ReviewsPage(),
    const UserProfilePage(),
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
      body: allPages[_currentBottomNavIndex],
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
