import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AccountInfo { newUser, oldUser, error, defo }

Future<bool> emailAlreadyInUse(String? email, {bool edit = true}) async {
  debugPrint("email = $email");
  if (email == null) {
    return false;
  }
  try {
    bool isInUse = false;
    var value = await FirebaseStorage.instance.ref().listAll();
    debugPrint("value = $value");
    for (var i in value.items) {
      final dt = await i.getData();
      final s = String.fromCharCodes(dt!);
      debugPrint("s = $s");
      if (s == email) {
        isInUse = true;
        break;
      }
    }

    // FirebaseStorage.instance.ref("emails/").list();
    return isInUse;
  } catch (err) {
    debugPrint(err.toString());
    return false;
  }
}

addUser(String email) {
  FirebaseStorage.instance.ref('emails/').putString(email);
  debugPrint("Added email $email");
}

class GAuthService extends ChangeNotifier {
  final gSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  static AccountInfo acc = AccountInfo.defo;

  GoogleSignInAccount get user => _user!;
  AccountInfo get userInfo => acc;

  Future<bool> isNewUser({bool edit = true}) async {
    return await emailAlreadyInUse(_user?.email, edit: edit);
  }

  Future<bool?> googleLogIn({bool newUser = false}) async {
    final guser = await gSignIn.signIn();
    if (guser == null) {
      acc = AccountInfo.defo;
      notifyListeners();
      return null;
    }

    _user = guser;

    final gauth = await guser.authentication;
    final creds = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    bool isInUse = await isNewUser();
    if (newUser) {
      if (isInUse) {
        return false;
      }
    } else {
      if (!isInUse) {
        return false;
      }
    }
    try {
      await FirebaseAuth.instance.signInWithCredential(creds);
      if (newUser) {
        addUser(guser.email);
      }
      debugPrint("isInUse = $isInUse");
      if (isInUse) {
        acc = AccountInfo.oldUser;
        notifyListeners();
        return true;
      }
      acc = AccountInfo.newUser;
      notifyListeners();
    } on FirebaseException catch (e) {
      debugPrint(e.code);
    }

    return null;
    // notifyListeners();
  }
}
