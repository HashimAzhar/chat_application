import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildStoryItem extends StatelessWidget {
  String imageUrl;
  String name;
  bool isMyStatus;
  BuildStoryItem({
    super.key,
    required this.imageUrl,
    required this.name,
    this.isMyStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.w,
      child: Column(
        children: [
          Container(
            height: 58.h,
            width: 58.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.pink, Colors.purple],
              ),
              border: Border.all(
                color: const Color.fromARGB(255, 235, 236, 236),
                width: 1,
              ),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29.r),
                child: Image.network(
                  imageUrl,
                  width: 52.w,
                  height: 52.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 7.h),
          Container(
            width: 68.w,
            height: 17.h,
            child: Center(
              child: Text(
                name,
                softWrap: false,
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
