import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AccountInfo { newUser, oldUser, error, defo }

class GAuthService extends ChangeNotifier {
  final gSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  static AccountInfo acc = AccountInfo.defo;

  GoogleSignInAccount get user => _user!;

  Future<bool> emailAlreadyInUse(String email) async {
    try {
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (list.isNotEmpty) {
        return true;
      }

      return false;
    } catch (err) {
      debugPrint(err.toString());
      return false;
    }
  }

  Future googleLogIn() async {
    final guser = await gSignIn.signIn();
    if (guser == null) {
      acc = AccountInfo.newUser;
      return;
    }

    _user = guser;

    final gauth = await guser.authentication;
    final creds = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(creds);
    } on FirebaseException catch (e) {
      debugPrint(e.code);
    }
    // notifyListeners();
    bool isInUse = await emailAlreadyInUse(guser.email);
    if (isInUse) {
      acc = AccountInfo.newUser;
      return;
    }
    acc = AccountInfo.newUser;
    notifyListeners();
  }
}
