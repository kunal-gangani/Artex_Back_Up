import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/views/HomePage/assets/widgets/listview_container.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:toastification/toastification.dart';

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
        backgroundColor: Colors.blue.shade200,
        title: Text(
          "Welcome Art Aficionado",
          style: TextStyle(
            fontSize: 20.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              toastification.show(
                context: context,
                type: ToastificationType.success,
                alignment: Alignment.bottomCenter,
                style: ToastificationStyle.flatColored,
                title: const Text(
                  "Icon Clicked",
                ),
                autoCloseDuration: const Duration(
                  seconds: 3,
                ),
              );
            },
            icon: Icon(
              Icons.favorite_border_outlined,
              size: 32.w,
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
                itemBuilder: (
                  context,
                  index,
                  realIndex,
                ) {
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
                  autoPlayInterval: const Duration(
                    seconds: 3,
                  ),
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
                  itemCount: 5,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return listViewContainer(
                      thumbnail:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbYjCfxjyOC3ePDsItz5mlGbKr0ipQjsNRyA&s",
                      painting: "Mona Lisa",
                      price: 18000,
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
                  itemCount: 5,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return listViewContainer(
                      thumbnail:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGOHLRlRzuXt7BYpRy1gcTKy5iUyl-Bbjs1A&s",
                      painting: "Lona Misa",
                      price: 25000,
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
                  itemCount: 5,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return listViewContainer(
                      thumbnail:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3MYztg-t9zowtUIGHSFYfKCejH1Khae_Zaw&s",
                      painting: "Lonawala",
                      price: 30000,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
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
              color: Colors.grey.withOpacity(
                0.2,
              ),
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
                Icons.summarize,
              ),
              selectedColor: Colors.green,
              title: Text(
                "Bid Summary",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SalomonBottomBarItem(
              selectedColor: Colors.red,
              icon: const Icon(
                Icons.gavel,
              ),
              title: Text(
                "Bids",
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
