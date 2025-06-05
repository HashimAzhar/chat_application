import 'package:chat_application/controller/user_provider.dart';
import 'package:chat_application/models/user_model.dart';
import 'package:chat_application/widgets/profile_image_picker_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userAsync = ref.watch(userByIdProvider(uid ?? ''));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 2.2,
            colors: [const Color(0xFF43116A).withOpacity(0.9), Colors.black],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: userAsync.when(
              data: (user) {
                return Column(
                  children: [
                    SizedBox(height: 30.h),

                    // Centered Profile
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60.r,
                                backgroundImage: NetworkImage(
                                  user.photoUrl.isNotEmpty
                                      ? user.photoUrl
                                      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIwRBD9gNuA2GjcOf6mpL-WuBhJADTWC3QVQ&s',
                                ),
                              ),
                              ProfileImagePickerButton(),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            user.name,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            user.email,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[400],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Settings Options (cleaned)
                    _buildSettingTile(
                      Icons.notifications_none,
                      'Notifications',
                    ),
                    _buildSettingTile(Icons.palette_outlined, 'Theme'),

                    const Spacer(),

                    // Logout Button
                    _buildActionButton(
                      icon: Icons.logout,
                      title: 'Logout',
                      color: Colors.deepPurpleAccent,
                      onPressed: () {},
                    ),
                    SizedBox(height: 14.h),

                    // Delete Button
                    _buildActionButton(
                      icon: Icons.delete_forever,
                      title: 'Delete Account',
                      color: Colors.redAccent,
                      onPressed: () {},
                    ),
                    SizedBox(height: 25.h),
                  ],
                );
              },
              loading:
                  () => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
              error:
                  (error, stack) => Center(
                    child: Text(
                      'Error: $error',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24.sp),
          SizedBox(width: 16.w),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white54,
            size: 16.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
