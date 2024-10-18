import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minor_project/model/user_data_model.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper authHelper = AuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String verificationMyId = "";

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

  Future<void> phoneVerification({required String phoneNumber}) async {
    await auth.verifyPhoneNumber(
      phoneNumber: "+91$phoneNumber",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {
        if (error.code == "invalid-phone-number") {
          log("Phone Number is Invalid Please check.....");
        } else {
          log("ERROR : ${error.code}");
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        verificationMyId = verificationId;
        log("NUMBER : $verificationMyId");
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<Map<String, dynamic>> checkMyOTP({required String otp}) async {
    Map<String, dynamic> res = {};
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationMyId, smsCode: otp);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      res['user'] = user;
    } catch (e) {
      log("ERROR : $e");
      res['error'] = e;
    }

    return res;
  }

  Future<void> logOut() async {
    await auth.signOut();
  }
}
