import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileImageService {
  final _picker = ImagePicker();
  final _supabase = Supabase.instance.client;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> pickAndUploadProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final file = File(pickedFile.path);
    final userId = _auth.currentUser!.uid;
    final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = 'profile_images/$userId/$fileName';

    // Upload to Supabase
    await _supabase.storage
        .from('dp') // <-- Replace with your bucket name
        .upload(filePath, file);

    final imageUrl = _supabase.storage.from('dp').getPublicUrl(filePath);

    // Update Firestore
    await _firestore.collection('users').doc(userId).update({
      'photoUrl': imageUrl,
    });
  }
}
