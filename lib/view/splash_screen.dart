import 'package:chat_application/controller/google_auth_provider.dart';
import 'package:chat_application/routes/route_names.dart';
import 'package:chat_application/widgets/authentication_button.dart';
import 'package:chat_application/widgets/rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: 17.h,
          bottom: 17.h,
          left: 24.w,
          right: 24.w,
        ),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 2.2,
            colors: [
              Color(0xFF43116A).withOpacity(0.9),
              Color.fromARGB(255, 0, 0, 0),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 16.w,
                      height: 19.2.h,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Chatbox',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                // Headline
                Text(
                  'Connect\nfriends\neasily &\nquickly',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 68.sp,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),

                SizedBox(height: 16.h),

                // Subtext
                Text(
                  'Our chat app is the perfect way to stay connected with friends and family.',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    color: Color(0xFFB9C1BE),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),

                SizedBox(height: 38.h),

                Center(
                  child: Container(
                    height: 48.h,
                    width: 184.w,
                    child: AuthenticationButton(
                      ontap: () {
                        ref
                            .read(googleAuthProvider)
                            .handleGoogleSignIn(context);
                      },
                      imagePath: 'assets/images/google.png',
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFFCDD1D0).withOpacity(.5),
                        thickness: 1.h,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Text(
                        'OR',
                        style: GoogleFonts.poppins(
                          color: Color(0xFFD6E4E0),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFFCDD1D0).withOpacity(.5),
                        thickness: 1.h,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteNames.signUpScreen);
                  },
                  child: RoundedRectangleButton(text: 'Sign Up with Email'),
                ),

                SizedBox(height: 46.h),

                Row(
                  children: [
                    Text(
                      'Existing account?',
                      style: GoogleFonts.poppins(
                        color: Color(0xFFB9C1BE),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Get.toNamed(RouteNames.login);
                      },
                      child: Text(
                        'Log in',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
