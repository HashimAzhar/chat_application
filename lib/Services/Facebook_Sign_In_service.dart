import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        return await _auth.signInWithCredential(facebookAuthCredential);
      } else {
        print("❌ Facebook Sign-In failed: ${result.message}");
        return null;
      }
    } catch (e) {
      print("❌ Facebook Sign-In exception: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
  }
}
