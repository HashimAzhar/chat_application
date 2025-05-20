import 'package:chat_application/controller/obsecure_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextField extends StatelessWidget {
  final String hintText;
  final bool isPasswordField;

  const BuildTextField({
    super.key,
    required this.hintText,
    this.isPasswordField = false,
  });

  @override
  Widget build(BuildContext context) {
    print("😂Building BuildTextField with hint: $hintText");

    return Consumer(
      builder: (context, ref, child) {
        final isObscure = ref.watch(obsecureTextProvider);

        return Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextField(
            obscureText: isPasswordField ? isObscure : false,
            style: GoogleFonts.poppins(fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              border: InputBorder.none,
              suffixIcon:
                  isPasswordField
                      ? IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          ref.read(obsecureTextProvider.notifier).state =
                              !isObscure;
                        },
                      )
                      : null,
            ),
          ),
        );
      },
    );
  }
}
