import 'package:firebase_auth/firebase_auth.dart';
import 'package:matimela/src/models/user.dart';

class AuthService {
  // firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user from firebase instance
  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser != null
        ? User(
            displayName: firebaseUser.displayName,
            email: firebaseUser.email,
            id: firebaseUser.uid,
            phone: firebaseUser.phoneNumber)
        : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser user = authResult.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future sigOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
