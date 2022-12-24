import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_cats_app/model/user_model.dart';
import 'package:pet_cats_app/services/storage_service.dart';

class AuthServices {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Future<bool> signUp({
    required String email,
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((value) => value.docs);
      if (usersSnapshot.isNotEmpty) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("ok"),
              )
            ],
            title: const Text(
              "this username is already used",
            ),
          ),
        );
        return false;
      }
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? signedIn = authResult.user;
      if (signedIn != null) {
        _firestore.collection('users').doc(signedIn.uid).set({
          'userId': signedIn.uid,
          'email': email,
          'username': username,
          'imageUrl': '',
        });
        return true;
      }
      return false;
    } catch (e) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ok"),
            )
          ],
          title: Text(
            e.toString(),
          ),
        ),
      );
      return false;
    }
  }

  static Future<bool> signIn({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((value) => value.docs);
      if (usersSnapshot.isEmpty) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("ok"),
              )
            ],
            title: const Text(
              "this username doesn't exist",
            ),
          ),
        );
        return false;
      }
      final String email = usersSnapshot.first.get('email');
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ok"),
            )
          ],
          title: Text(
            e.toString(),
          ),
        ),
      );
      return false;
    }
  }

  static Future<void> logout({required BuildContext context}) async{
    await _auth.signOut();
  }

  static Future<void> deleteUser({required BuildContext context}) async{
    try {
      await _auth.currentUser!.delete();
      await _firestore.collection('users').doc(UserModel.shared.userId).delete();
      await StorageService.deleteProfileImage();
    }catch (e){
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ok"),
            )
          ],
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  static Future<void> resetPassword({required String email,required BuildContext context}) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("ok"),
            )
          ],
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
  }
}
