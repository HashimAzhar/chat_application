import 'package:chat_application/controller/obsecure_text_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTextField extends ConsumerStatefulWidget {
  final String hintText;
  final bool isPasswordField;
  final TextEditingController? controller;

  const BuildTextField({
    super.key,
    required this.hintText,
    this.isPasswordField = false,
    this.controller,
  });

  @override
  ConsumerState<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends ConsumerState<BuildTextField> {
  late final TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObscure = ref.watch(obsecureTextProvider);

    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: widget.controller ?? _internalController,
        obscureText: widget.isPasswordField ? isObscure : false,
        style: GoogleFonts.poppins(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14.sp),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          border: InputBorder.none,
          suffixIcon:
              widget.isPasswordField
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
  }
}
