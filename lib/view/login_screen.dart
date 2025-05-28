import 'package:chat_application/controller/google_auth_provider.dart';
import 'package:chat_application/controller/login_provider.dart';
import 'package:chat_application/routes/route_names.dart';
import 'package:chat_application/widgets/authentication_button.dart';
import 'package:chat_application/widgets/build_text_field.dart';
import 'package:chat_application/widgets/rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 17.h),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
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

                Text(
                  'Log in',
                  style: GoogleFonts.poppins(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Welcome back! Please enter your details.',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Color(0xFFB9C1BE),
                  ),
                ),
                SizedBox(height: 30.h),

                BuildTextField(controller: emailController, hintText: 'Email'),
                SizedBox(height: 20.h),
                BuildTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  isPasswordField: true,
                ),
                SizedBox(height: 10.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        color: Color(0xFFB9C1BE),
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    ref
                        .read(loginProvider.notifier)
                        .login(
                          context,
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                  },
                  child:
                      loginState.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : RoundedRectangleButton(text: 'Log in'),
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13.w),
                      child: Text(
                        'OR',
                        style: GoogleFonts.poppins(
                          color: Color(0xFFD6E4E0),
                          fontSize: 14.sp,
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
                SizedBox(height: 46.h),

                Row(
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: GoogleFonts.poppins(
                        color: Color(0xFFB9C1BE),
                        fontSize: 14.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to signup
                        Get.offNamed(RouteNames.signUpScreen);
                      },
                      child: Text(
                        'Sign up',
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
