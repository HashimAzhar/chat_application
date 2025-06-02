import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stories',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),

                // Static story avatar UI
                SizedBox(
                  height: 100.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildStoryItem(
                        "My Story",
                        'https://via.placeholder.com/150',
                        isMyStory: true,
                      ),
                      _buildStoryItem(
                        "Alice",
                        'https://randomuser.me/api/portraits/women/1.jpg',
                      ),
                      _buildStoryItem(
                        "Bob",
                        'https://randomuser.me/api/portraits/men/2.jpg',
                      ),
                      _buildStoryItem(
                        "Charlie",
                        'https://randomuser.me/api/portraits/men/3.jpg',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                Center(
                  child: Text(
                    "No stories to show",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoryItem(
    String name,
    String imageUrl, {
    bool isMyStory = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient:
                      isMyStory
                          ? null
                          : const LinearGradient(
                            colors: [Colors.purple, Colors.deepPurpleAccent],
                          ),
                ),
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              if (isMyStory)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(name, style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
        ],
      ),
    );
  }
}
