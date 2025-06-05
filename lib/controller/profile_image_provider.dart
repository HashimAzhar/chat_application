import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/profile_image_service.dart';

final profileImageProvider = AsyncNotifierProvider<ProfileImageNotifier, void>(
  ProfileImageNotifier.new,
);

class ProfileImageNotifier extends AsyncNotifier<void> {
  final _service = ProfileImageService();

  @override
  Future<void> build() async {}

  Future<void> uploadImage() async {
    state = const AsyncLoading();
    try {
      await _service.pickAndUploadProfileImage();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
