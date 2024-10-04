import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/views/BidsPlacedPage/bids_placed.dart';
import 'package:minor_project/views/FavourtiesPage/favourites_page.dart';
import 'package:minor_project/views/HomePage/assets/widgets/listview_container.dart';
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

  List<Widget> allPages = [
    const HomePageComponent(),
    const BidsPlacedPage(),
    ArtReviewsPage(),
    const UserProfilePage(),
  ];

  // List of AppBars to switch based on the selected index
  final List<AppBar> appBars = [
    AppBar(
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
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Flexify.go(
                  const FavouritesPage(),
                  animation: FlexifyRouteAnimations.blur,
                  animationDuration: Durations.medium1,
                );
              },
              icon: Icon(
                Icons.favorite,
                size: 32.w,
                color: Colors.red,
              ),
            ),
            if (favouriteItems.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: const BoxConstraints(
                    maxWidth: 20,
                    maxHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      '${favouriteItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 10.w,
        ),
      ],
    ),
    AppBar(
      title: const Text(
        "Bids Placed",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blueAccent,
    ),
    AppBar(
      title: const Text(
        "Reviews",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blueAccent,
    ),
    AppBar(
      title: const Text(
        "User Profile",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blueAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars[_currentBottomNavIndex],
      body: allPages[_currentBottomNavIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(
                0,
                3,
              ),
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
              icon: const Icon(Icons.reviews),
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
              icon: const Icon(Icons.person),
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
