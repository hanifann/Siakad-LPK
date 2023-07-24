
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:siakad_lpk/features/login/presentation/bloc/login_bloc.dart';
import 'package:siakad_lpk/features/login/presentation/bloc/user_bloc.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/column_title_and_textfield_widget.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/custom_textfield_widget.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/custom_dialog_widget.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(
          create: (context) => sl<LoginBloc>(),
    
        ),
          BlocProvider(
              create: (context) => sl<UserBloc>(),
          ),
        ],
      child: const LoginPage(),
    );
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
            loginBlocListenerWidget(),
            SizedBox(height: 8.h,),
            registerTextWidget(context)
          ],
        ),
      ),
    );
  }

  MultiBlocListener loginBlocListenerWidget() {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if(state is LoginSucceed){
              context.read<UserBloc>().add(GetUserEvent());
            } else if (state is LoginFailed){
              context.pop();
              showDialog(
                context: context, 
                builder: (_) => ErrorDialog(errorValue: state.error.message!)
              );
            } else {
              showDialog(
                context: context, 
                builder: (_) => const LoadingDialog()
              );
            }
          } 
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if(state is UserLoaded){
              context.pushReplacement('/');
            } else if (state is UserFailed){
              context.pop();
              showDialog(
                context: context, 
                builder: (_) => ErrorDialog(errorValue: state.error.message!)
              );
            }
          },
        ),
      ],
      child: loginBtnWidget(),
    );
  }

  Center registerTextWidget(BuildContext context) {
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
                context.pushReplacement('/register');
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
          context.read<LoginBloc>().add(
            PostLoginEvent(
              emailEditingController.text, 
              passwordEditingController.text
            )
          );
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