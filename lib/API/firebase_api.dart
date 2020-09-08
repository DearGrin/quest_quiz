import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseApi {


  Future<String> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return'The password provided is too weak.'; // todo manage callback
      } else if (e.code == 'email-already-in-use') {
        return'The account already exists for that email.'; // todo manage callback
      }
    } catch (e) {
      return e.toString();
    }
    return  "uid" + FirebaseAuth.instance.currentUser.uid;
  }

  Future<String> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return 'Sign in successful!';
  }

  Future<String> changePassword(String password) async{
    String email = FirebaseAuth.instance.currentUser.email;
    EmailAuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential);
    return 'Password changed!';
  }

  void signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  Future<String> authEventHandler(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        return 'null';
      } else {
        return user.uid;
      }
    });
    return 'null' as Future<String>;
  }

  Future<String> getUserId() async{
    return FirebaseAuth.instance.currentUser.uid;
  }
  Future<void> sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}