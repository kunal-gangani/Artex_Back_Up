import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minor_project/helper/auth_helper.dart';
import 'package:minor_project/model/famous_data_model.dart';
import 'package:minor_project/model/hots_data_model.dart';
import 'package:minor_project/model/house_holds_data_model.dart';

class FCMHelper {
  FCMHelper._();

  static final FCMHelper fcmHelper = FCMHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // int favoriteId = 1;

  Future<void> addFavoriteHouseHolds({
    required HouseHoldsDataModel data,
  }) async {
    await firestore
        .collection("User Data")
        .doc(AuthHelper.authHelper.auth.currentUser!.email)
        .collection("favorite")
        .doc("${data.artId}")
        .set(data.toMap());
  }

  Future<void> addFavoriteHouse({
    required HotsDataModel data,
  }) async {
    await firestore
        .collection("User Data")
        .doc(AuthHelper.authHelper.auth.currentUser!.email)
        .collection("favorite")
        .doc("${data.artId}")
        .set(data.toMap());
  }

  Future<void> addFavoriteFamous({
    required FamousDataModel data,
  }) async {
    await firestore
        .collection("User Data")
        .doc(AuthHelper.authHelper.auth.currentUser!.email)
        .collection("favorite")
        .doc("${data.artId}")
        .set(data.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllFavoriteItems() {
    return firestore
        .collection("User Data")
        .doc(AuthHelper.authHelper.auth.currentUser!.email)
        .collection("favorite")
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchCurrentUserData() async {
    return await firestore
        .collection("User Data")
        .doc(AuthHelper.authHelper.auth.currentUser!.email)
        .get();
  }

}
