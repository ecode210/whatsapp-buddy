import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CRM extends ChangeNotifier {
  bool loggedIn = false;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
  );
  GoogleSignInAccount? user;

  Future<UserCredential> googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      user = googleUser;
      loggedIn = true;
      notifyListeners();
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
    notifyListeners();
  }
}
