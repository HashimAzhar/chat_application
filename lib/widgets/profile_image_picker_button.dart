import 'package:chat_application/controller/profile_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImagePickerButton extends ConsumerStatefulWidget {
  const ProfileImagePickerButton({super.key});

  @override
  ConsumerState<ProfileImagePickerButton> createState() =>
      _ProfileImagePickerButtonState();
}

class _ProfileImagePickerButtonState
    extends ConsumerState<ProfileImagePickerButton> {
  bool _hasSetupListener = false;
  bool _userInitiatedUpload = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileImageProvider);

    if (!_hasSetupListener) {
      _hasSetupListener = true;

      ref.listen(profileImageProvider, (previous, next) {
        if (!_userInitiatedUpload) return;

        if (next is AsyncLoading) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Uploading image...')));
        } else if (next is AsyncData) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Upload successful!')));
          _userInitiatedUpload = false;
        } else if (next is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: ${next.error}')),
          );
          _userInitiatedUpload = false;
        }
      });
    }

    return Positioned(
      bottom: 1,
      right: 1,
      child: GestureDetector(
        onTap: () {
          _userInitiatedUpload = true;
          ref.read(profileImageProvider.notifier).uploadImage();
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child:
              state.isLoading
                  ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  : const Icon(Icons.edit, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
