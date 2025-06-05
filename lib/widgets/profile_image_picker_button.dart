import 'package:chat_application/controller/profile_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImagePickerButton extends ConsumerWidget {
  const ProfileImagePickerButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileImageProvider);

    // ✅ Listen in build method (allowed)
    ref.listen(profileImageProvider, (previous, next) {
      if (next is AsyncLoading) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Uploading image...')));
      } else if (next is AsyncData) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Upload successful!')));
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Upload failed: ${next.error}')));
      }
    });

    return Positioned(
      bottom: 1,
      right: 1,
      child: GestureDetector(
        onTap: () {
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
