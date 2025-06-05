import 'package:chat_application/Services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstSplashView extends StatefulWidget {
  const FirstSplashView({super.key});

  @override
  State<FirstSplashView> createState() => _FirstSplashViewState();
}

class _FirstSplashViewState extends State<FirstSplashView> {
  final SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();

    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 2.2,
            colors: [const Color(0xFF43116A).withOpacity(0.9), Colors.black],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom Logo (circle + chat bubble shape)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Purple Circle
                    Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F3FBF),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),

                    // White chat bubble tail
                    Positioned(
                      bottom: 20.h,
                      right: 25.w,
                      child: Transform.rotate(
                        angle: 0.5,
                        child: Container(
                          width: 35.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    // White Chat bubble inside
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline,
                        size: 50.w,
                        color: const Color(0xFF6F3FBF),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                // App Name
                Text(
                  "ChatSphere",
                  style: GoogleFonts.poppins(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),

                SizedBox(height: 10.h),

                // Tagline
                Text(
                  "Connect. Chat. Chill.",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
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
