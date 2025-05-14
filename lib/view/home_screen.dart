import 'package:chat_application/widgets/build_story_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 17.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  height: 44.h,
                  width: 327.w,

                  child: Row(
                    children: [
                      Container(
                        height: 44.h,
                        width: 44.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.r),
                          border: Border.all(
                            color: Color(0xFF363F3B),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/Search.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                      SizedBox(width: 90.w),
                      Text(
                        'Home',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(width: 91.w),
                      Container(
                        height: 44.h,
                        width: 44.w,
                        child: Image.asset(
                          'assets/images/profile.png',
                          height: 44.h,
                          width: 44.w,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  margin: EdgeInsets.only(left: 21.w),
                  width: 359.w,
                  height: 82.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        1 +
                        6, // 1 for 'My Status', 6 for others (dynamic later)
                    itemBuilder: (context, index) {
                      // My Status
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(right: 13.w),
                          child: BuildStoryItem(
                            imageUrl:
                                'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
                            name: 'My Status',
                            isMyStatus: true,
                          ),
                        );
                      }

                      // Other Users' Stories
                      return Padding(
                        padding: EdgeInsets.only(right: index == 6 ? 0 : 13.w),
                        child: BuildStoryItem(
                          imageUrl:
                              'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
                          name: 'Tina',
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      // Handle
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      // Chat list
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
