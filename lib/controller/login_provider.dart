import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../routes/route_names.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>(
  (ref) => LoginNotifier(),
);

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  LoginNotifier() : super(const AsyncData(null));

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    state = const AsyncLoading();
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;

      if (user != null) {
        final fcmToken = await FirebaseMessaging.instance.getToken();

        await _firestore.collection('users').doc(user.uid).update({
          'fcmToken': fcmToken,
          'isOnline': true,
          'lastSeen': FieldValue.serverTimestamp(),
        });

        state = const AsyncData(null);
        Get.offAllNamed(RouteNames.homeScreen);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
