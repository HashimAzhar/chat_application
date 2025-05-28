import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const RoundedRectangleButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          width: double.infinity,
          height: 48.h,
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: const Color(0xFF000E08),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
