
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/column_title_and_textfield_widget.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/custom_textfield_widget.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 128.r,
              height: 128.r,
            ),
            SizedBox(height: 64.h,),
            emailTextfieldWidget(),
            SizedBox(height: 16.h,),
            passwordTextfieldWidget(),
            SizedBox(height: 24.h,),
            loginBtnWidget(),
            SizedBox(height: 8.h,),
            registerTextWidget()
          ],
        ),
      ),
    );
  }

  Center registerTextWidget() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: kPrimaryTextColor
          ),
          children: [
            const TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(
                fontWeight: FontWeight.w500
              )
            ),
            TextSpan(
              text: 'Daftar',
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap= (){
    
              }
            ),
          ]
        )
      ),
    );
  }

  SizedBox loginBtnWidget() {
    return SizedBox(
      width: 1.sw,
      height: 42.h,
      child: ElevatedButton(
        onPressed: () {
          
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor
        ),
        child: CustomTextWidget(
          text: 'Login',
          color: Colors.white,
          size: 14.sp,
          weight: FontWeight.w500,
        )
      ),
    );
  }

  ColumnTitleAndTextFieldWidget passwordTextfieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: passwordEditingController, 
        hint: '',
        isObscure: true,
      ), 
      title: 'Password'
    );
  }

  ColumnTitleAndTextFieldWidget emailTextfieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: emailEditingController, 
        hint: ''
      ), 
      title: 'Email'
    );
  }
}