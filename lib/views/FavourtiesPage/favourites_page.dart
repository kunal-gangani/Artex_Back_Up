import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minor_project/helper/auth_helper.dart';
import 'package:minor_project/helper/fcm_helper.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Flexify.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        elevation: 2,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Your Favourites",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FCMHelper.fcmHelper.fetchAllFavoriteItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error",
              ),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> allData =
                data?.docs ?? [];

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              child: ListView.separated(
                itemCount: allData.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(allData[index]),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) =>
                              _removeItem(allData[index]['artId']),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onLongPress: () {
                        _showDeleteBottomSheet(context, allData[index]['artId'],
                            allData[index]['artName']);
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          height: 125.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade100,
                                Colors.blue.shade300,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allData[index]['artName'],
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "by ${allData[index]['painter']}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // Method to show a modal bottom sheet for delete confirmation
  void _showDeleteBottomSheet(
      BuildContext context, dynamic artId, String artName) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.r),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Remove $artName?",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _removeItem(artId);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Remove",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Remove item from the list and update the state.
  void _removeItem(dynamic artId) async {
    String artIdString = artId.toString();

    await FirebaseFirestore.instance
        .collection("User Data")
        .doc(AuthHelper.authHelper.auth.currentUser!.email)
        .collection("favorite")
        .doc(artIdString)
        .delete();
  }
}
