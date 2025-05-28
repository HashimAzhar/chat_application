import 'package:chat_application/controller/email_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/google_auth_provider.dart';
import '../../routes/route_names.dart';
import '../../widgets/authentication_button.dart';
import '../../widgets/build_text_field.dart';
import '../../widgets/rounded_rectangle_button.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 17.h),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              radius: 2.2,
              colors: [
                const Color(0xFF43116A).withOpacity(0.9),
                const Color.fromARGB(255, 0, 0, 0),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Logo
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
                'Sign up',
                style: GoogleFonts.poppins(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Create your account to continue using Chatbox.',
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: const Color(0xFFB9C1BE),
                ),
              ),
              SizedBox(height: 30.h),

              BuildTextField(
                controller: _usernameController,
                hintText: 'Username',
              ),
              SizedBox(height: 20.h),
              BuildTextField(controller: _emailController, hintText: 'Email'),
              SizedBox(height: 20.h),
              BuildTextField(
                controller: _passwordController,
                hintText: 'Password',
                isPasswordField: true,
              ),
              SizedBox(height: 20.h),

              signUpState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RoundedRectangleButton(
                    text: 'Create Account',
                    onTap: () {
                      ref
                          .read(signUpProvider.notifier)
                          .signUp(
                            context,
                            _usernameController.text.trim(),
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                    },
                  ),
              SizedBox(height: 30.h),

              /// OR divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: const Color(0xFFCDD1D0).withOpacity(.5),
                      thickness: 1.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child: Text(
                      'OR',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFD6E4E0),
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: const Color(0xFFCDD1D0).withOpacity(.5),
                      thickness: 1.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              /// Google Auth Button
              Center(
                child: SizedBox(
                  height: 48.h,
                  width: 184.w,
                  child: AuthenticationButton(
                    ontap: () {
                      ref.read(googleAuthProvider).handleGoogleSignIn(context);
                    },
                    imagePath: 'assets/images/google.png',
                  ),
                ),
              ),

              SizedBox(height: 46.h),

              /// Already have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFB9C1BE),
                      fontSize: 14.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offNamed(RouteNames.login);
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
    );
  }
}
