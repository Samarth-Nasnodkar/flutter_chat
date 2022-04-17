import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  String? _username;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  String? get userName => _username;

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var ref = FirebaseDatabase.instance.ref('/u');
      ref.equalTo(email).once().then((v) {
        _username = v.snapshot.value.toString();
      });
      return null;
    } on FirebaseAuthException catch (e) {
      // debugPrint('Sign in Error: ${e.message}');
      return e.message;
    }
  }

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // var ref = FirebaseDatabase.instance.ref('/u/$email');
      // _username = email.replaceAll('@gmail.com', '');
      // ref.set({'username': _username});
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
      // return false;
    }
  }
}
