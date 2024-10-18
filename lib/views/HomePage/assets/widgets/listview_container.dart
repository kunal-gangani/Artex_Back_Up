import 'dart:developer';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minor_project/helper/fcm_helper.dart';
import 'package:minor_project/model/famous_data_model.dart';
import 'package:minor_project/model/hots_data_model.dart';
import 'package:minor_project/model/house_holds_data_model.dart';
import 'package:minor_project/views/DetailPage/detail_page.dart';
import 'package:toastification/toastification.dart';

List<dynamic> favouriteItems = [];

// Method for the HouseHold List View Container
GestureDetector houseListViewContainer({
  required HouseHoldsDataModel e,
  required Function() setState,
  required int index,
}) {
  bool isFavorited = false;

  return GestureDetector(
    onTap: () {
      _navigateToHouseDetailPage(
        house: e,
        index: index,
      );
    },
    child: Stack(
      children: [
        _buildItemContainer(
          imageUrl: e.imageUrl,
          title: e.artName,
          price: e.minBidPrice.toDouble(),
          stock: e.stock,
        ),
        _buildAddButton(
          isFavorited: isFavorited,
          onTap: () async {
            isFavorited = !isFavorited;
            setState();

            log("Favorite : $isFavorited");

            await FCMHelper.fcmHelper
                .addFavoriteHouseHolds(data: e)
                .then((value) {
              debugPrint(
                'Item added to the favourites list.',
              );
              toastification.show(
                backgroundColor: isFavorited ? Colors.red[50] : Colors.blue[50],
                autoCloseDuration: const Duration(
                  seconds: 2,
                ),
                title: isFavorited
                    ? const Text(
                        "Added to Favourites ",
                      )
                    : const Text(
                        "Removed from Favourites",
                      ),
              );
            });
          },
        ),
      ],
    ),
  );
}

// Method for the Hot List View Container
GestureDetector hotListViewContainer({
  required HotsDataModel e,
  required Function() setState,
  required int index,
}) {
  bool isFavorited = false;

  return GestureDetector(
    onTap: () {
      _navigateToHotsDetailPage(
        hots: e,
        index: index,
      );
    },
    child: Stack(
      children: [
        _buildItemContainer(
          imageUrl: e.imageUrl,
          title: e.artName,
          price: e.minBidPrice.toDouble(),
          stock: e.stock,
        ),
        _buildAddButton(
          isFavorited: isFavorited,
          onTap: () async {
            isFavorited = !isFavorited;
            setState();
            log("Favorite : $isFavorited");
            await FCMHelper.fcmHelper.addFavoriteHouse(data: e).then((value) {
              debugPrint('Item added to the favourites list.');
            });
            toastification.show(
              backgroundColor: isFavorited ? Colors.red[50] : Colors.blue[50],
              autoCloseDuration: const Duration(
                seconds: 2,
              ),
              title: isFavorited
                  ? const Text(
                      "Added to Favourites ",
                    )
                  : const Text(
                      "Removed from Favourites",
                    ),
            );
          },
        ),
      ],
    ),
  );
}

// Method for the Famous List View Container
GestureDetector famousListViewContainer({
  required FamousDataModel e,
  required Function() setState,
  required int index,
}) {
  bool isFavorited = false;

  return GestureDetector(
    onTap: () {
      _navigateToFamousDetailPage(
        famous: e,
        index: index,
      );
    },
    child: Stack(
      children: [
        _buildItemContainer(
          imageUrl: e.imageUrl,
          title: e.artName,
          price: e.minBidPrice.toDouble(),
          stock: e.stock,
        ),
        _buildAddButton(
          isFavorited: isFavorited,
          onTap: () async {
            isFavorited = !isFavorited;
            setState();
            log(
              "Favorite : $isFavorited",
            );
            await FCMHelper.fcmHelper.addFavoriteFamous(data: e).then((value) {
              debugPrint('Item added to the favourites list.');
            });
            toastification.show(
              backgroundColor: isFavorited ? Colors.red[50] : Colors.blue[50],
              autoCloseDuration: const Duration(
                seconds: 2,
              ),
              title: isFavorited
                  ? const Text(
                      "Added to Favourites ",
                    )
                  : const Text(
                      "Removed from Favourites",
                    ),
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildItemContainer({
  required String imageUrl,
  required String title,
  required double price,
  required int stock,
}) {
  return Container(
    width: 170.w,
    padding: EdgeInsets.all(14.w),
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
          color: Colors.black.withOpacity(0.05),
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
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        // Text and Price Section
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                '\$ $price',
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
  );
}

// Positioned Add Button
Widget _buildAddButton({
  required bool isFavorited,
  required Function() onTap,
}) {
  return Positioned(
    top: 8.w,
    right: 8.w,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.favorite,
          color: isFavorited ? Colors.red : Colors.white,
          size: 24.sp,
        ),
      ),
    ),
  );
}

// Navigation function to Detail Page
void _navigateToHouseDetailPage({
  required HouseHoldsDataModel house,
  required int index,
}) {
  Flexify.go(
    DetailPage(
      artName: house.artName,
      imageUrl: house.imageUrl,
      painter: house.painter,
      description: house.description,
      minBidPrice: house.minBidPrice.toDouble(),
      index: index,
    ),
    animation: FlexifyRouteAnimations.blur,
    animationDuration: Durations.medium1,
  );
}

void _navigateToHotsDetailPage({
  required HotsDataModel hots,
  required int index,
}) {
  Flexify.go(
    DetailPage(
      artName: hots.artName,
      imageUrl: hots.imageUrl,
      painter: hots.painter,
      description: hots.description,
      minBidPrice: hots.minBidPrice.toDouble(),
      index: index,
    ),
    animation: FlexifyRouteAnimations.blur,
    animationDuration: Durations.medium1,
  );
}

void _navigateToFamousDetailPage({
  required FamousDataModel famous,
  required int index,
}) {
  Flexify.go(
    DetailPage(
      artName: famous.artName,
      imageUrl: famous.imageUrl,
      painter: famous.painter,
      description: famous.description,
      minBidPrice: famous.minBidPrice.toDouble(),
      index: index,
    ),
    animation: FlexifyRouteAnimations.blur,
    animationDuration: Durations.medium1,
  );
}
