import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  Stream<String> get onAuthStateChanged {
    return FirebaseAuth.instance.onAuthStateChanged
        .map((FirebaseUser user) => user?.uid);
  }

  Future<String> getUserId() async {
    return (await FirebaseAuth.instance.currentUser()).uid;
  }

  Future getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  Future<String> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = name;
    user.updateProfile(userUpdateInfo);
    user.reload();
    return user.uid;
  }

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    return user.uid;
  }

  Future<String> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.getCredential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        FirebaseUser user = authResult.user;

        return user.uid;
      } else {
        throw PlatformException(
            code: 'error missing google auth token',
            message: 'missing google auth token');
      }
    } else {
      throw PlatformException(
          code: 'error aborted by user', message: 'sign in aborted by user');
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection('doctors')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
