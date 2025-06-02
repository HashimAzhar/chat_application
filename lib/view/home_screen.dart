import 'package:chat_application/controller/user_provider.dart';
import 'package:chat_application/view/chat_screen.dart';
import 'package:chat_application/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListAsync = ref.watch(allUsersProvider);

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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chats',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/men/1.jpg',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Search Bar
                SearchTextField(),
                SizedBox(height: 20.h),

                // User List
                Expanded(
                  child: userListAsync.when(
                    data: (users) {
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 26.r,
                                  backgroundImage: NetworkImage(
                                    user.photoUrl.isEmpty
                                        ? 'https://via.placeholder.com/150'
                                        : user.photoUrl,
                                  ),
                                ),
                                title: Text(
                                  user.name,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  user.about,
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[400],
                                    fontSize: 13.sp,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Icon(
                                  Icons.circle,
                                  size: 10,
                                  color:
                                      user.isOnline
                                          ? Colors.green
                                          : Colors.grey,
                                ),
                                onTap: () {
                                  Get.to(
                                    ChatScreen(
                                      userName: user.name,
                                      userImage: user.photoUrl,
                                    ),
                                  );
                                },
                              ),
                              Divider(
                                color: Colors.white12,
                                thickness: 0.5,
                                indent: 70.w,
                                endIndent: 10.w,
                              ),
                            ],
                          );
                        },
                      );
                    },
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Center(child: Text('Error: $e')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
