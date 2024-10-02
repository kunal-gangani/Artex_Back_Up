import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minor_project/model/user_data_model.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper authHelper = AuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Todo : signUp Method

  Future<void> signUp({required UserDataModel userDataModel}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: userDataModel.email,
        password: userDataModel.password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await firestore
            .collection("User Data")
            .doc(userDataModel.email)
            .set(userDataModel.toMap);
      }
    } on FirebaseAuthException catch (e) {
      log("==================");
      log("ERROR : ${e.code}");
      log("==================");
    }
  }

  // Todo : signIn Method
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      log("==================");
      log("ERROR : ${e.code}");
      log("==================");
    }
  }
}
