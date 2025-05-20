import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? ontap;
  AuthenticationButton({super.key, required this.imagePath, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 48.h,
        width: 48.w,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFA8B0AF), width: 1),
          borderRadius: BorderRadius.circular(24.dg),
        ),
        child: Image.asset(imagePath),
      ),
    );
  }
}
