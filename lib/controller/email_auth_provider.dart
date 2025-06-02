import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../routes/route_names.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, AsyncValue<void>>(
  (ref) => SignUpNotifier(),
);

class SignUpNotifier extends StateNotifier<AsyncValue<void>> {
  SignUpNotifier() : super(const AsyncData(null));

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(
    BuildContext context,
    String username,
    String email,
    String password,
  ) async {
    state = const AsyncLoading();
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      final fcmToken = await FirebaseMessaging.instance.getToken();

      if (user != null) {
        final userData = {
          'uid': user.uid,
          'email': user.email ?? '',
          'name': username,
          'username': _generateUsername(username),
          'photoUrl': '',
          'fcmToken': fcmToken,
          'isOnline': true,
          'about': 'Hey there! I’m using ChatApp',
          'lastSeen': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        };

        await _firestore.collection('users').doc(user.uid).set(userData);
        state = const AsyncData(null);
        Get.offAllNamed(RouteNames.bottomNavView);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      Get.snackbar(
        "Signup Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String _generateUsername(String name) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.remainder(10000);
    return name.toLowerCase().replaceAll(' ', '_') + "_$timestamp";
  }
}
