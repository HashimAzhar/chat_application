import 'package:chat_application/Services/Google_Sign_In_Service.dart';
import 'package:chat_application/Services/Facebook_Sign_In_Service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_application/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final socialAuthProvider = Provider<SocialAuthController>((ref) {
  return SocialAuthController(ref);
});

class SocialAuthController {
  final Ref ref;
  SocialAuthController(this.ref);

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final userCredential = await GoogleSignInService.signInWithGoogle();
    await _postSignIn(context, userCredential);
  }

  Future<void> handleFacebookSignIn(BuildContext context) async {
    print('handleFacebookSignIn called');
    final userCredential = await FacebookSignInService.signInWithFacebook();
    await _postSignIn(context, userCredential);
  }

  Future<void> _postSignIn(
    BuildContext context,
    UserCredential? userCredential,
  ) async {
    if (userCredential != null) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _saveUserToFirestore(user);
      }

      Get.offAllNamed(RouteNames.homeScreen);
    } else {
      Get.snackbar(
        "Error",
        "Sign-In failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _saveUserToFirestore(User user) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    final userData = {
      'uid': user.uid,
      'email': user.email ?? '',
      'name': user.displayName ?? '',
      'username': _generateUsername(user.displayName ?? ''),
      'photoUrl': user.photoURL ?? '',
      'fcmToken': fcmToken,
      'isOnline': true,
      'about': 'Hey there! I’m using ChatApp',
      'lastSeen': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    };

    await userDocRef.set(userData, SetOptions(merge: true));
  }

  String _generateUsername(String name) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.remainder(10000);
    return name.toLowerCase().replaceAll(' ', '_') + "_$timestamp";
  }
}
