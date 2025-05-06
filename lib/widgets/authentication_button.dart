import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationButton extends StatelessWidget {
  String imagePath;
  AuthenticationButton({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 48.w,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFA8B0AF), width: 1),
        borderRadius: BorderRadius.circular(24.dg),
      ),
      child: Image.asset(imagePath),
    );
  }
}
