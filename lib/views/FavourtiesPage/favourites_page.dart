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
                      key: ValueKey(
                        allData[index],
                      ),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => _removeItem(
                              allData[index]['artId'],
                            ),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ],
                      ),
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
                              SizedBox(
                                height: 8.h,
                              ),
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
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  // Remove item from the list and update the state.
  void _removeItem(int index) async {
    await FirebaseFirestore.instance
        .collection("User Data")
        .doc(AuthHelper.authHelper.auth.currentUser!.email)
        .collection("favorite")
        .doc(index.toString())
        .delete();
  }
}
