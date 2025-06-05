import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CallLogScreen extends StatelessWidget {
  const CallLogScreen({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Calls',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.call, color: Colors.white, size: 28.sp),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Call List (static for UI)
                Expanded(
                  child: ListView(
                    children: List.generate(5, (index) {
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 26.r,
                              backgroundImage: NetworkImage(
                                'https://via.placeholder.com/150',
                              ),
                            ),
                            title: Text(
                              'Caller ${index + 1}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(
                                  index % 3 == 0
                                      ? Icons.call_missed
                                      : index % 2 == 0
                                      ? Icons.call_made
                                      : Icons.call_received,
                                  size: 16.sp,
                                  color:
                                      index % 3 == 0
                                          ? Colors.red
                                          : Colors.green,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Yesterday, 8:30 PM',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[400],
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.call,
                              color: Colors.greenAccent,
                              size: 22.sp,
                            ),
                          ),
                          Divider(
                            color: Colors.white12,
                            thickness: 0.5,
                            indent: 70.w,
                            endIndent: 10.w,
                          ),
                        ],
                      );
                    }),
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
