import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class CRM extends GetxController {
  bool loggedIn = false;

  Rx<String> fullName = "".obs;
  Rx<String> phoneNumber = "".obs;
  Rx<String> email = "".obs;
  Rx<String> address = "".obs;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
  );
  GoogleSignInAccount? user;

  Future<UserCredential> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      user = googleUser;
      loggedIn = true;
      update();
    }
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    user = null;
    FirebaseAuth.instance.signOut();
    update();
  }

  final firestore = FirebaseFirestore.instance.collection("buddy");

  void savedLeads(BuildContext context, bool thirdParty) async {
    DocumentReference doc = firestore.doc(user!.id);
    Map<String, dynamic> data = {
      "id": user!.id,
      "full name": fullName.value,
      "phone number": phoneNumber.value,
      "email": email.value,
      "address": address.value,
      "third party": thirdParty,
    };
    await doc.set(data).whenComplete(() {
      print("User leads added to the database");
      Get.back();
      Get.defaultDialog(
        title: "NOTICE",
        middleText: "Leads has been submitted",
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        titleStyle: Theme.of(context).textTheme.headline1,
        middleTextStyle: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.grey.shade900,
              fontSize: 15,
            ),
      );
    }).catchError((e) => print("error!"));
  }

  void savedThirdPartyLeads(BuildContext context, bool thirdParty) async {
    String uuid = const Uuid().v1().split("-").join();
    DocumentReference doc = firestore.doc("${user!.id}-$uuid");
    Map<String, dynamic> data = {
      "id": user!.id,
      "full name": fullName.value,
      "phone number": phoneNumber.value,
      "email": email.value,
      "address": address.value,
      "third party": thirdParty,
    };
    await doc.set(data).whenComplete(() {
      print("User leads added to the database");
      Get.back();
      Get.defaultDialog(
        title: "NOTICE",
        middleText: "Leads has been submitted",
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        titleStyle: Theme.of(context).textTheme.headline1,
        middleTextStyle: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.grey.shade900,
              fontSize: 15,
            ),
      );
    }).catchError((e) => print("error!"));
  }
}
