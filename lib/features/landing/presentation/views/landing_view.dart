
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LandingPage();
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget(),
            SizedBox(height: 4.h,),
            registrationStepContainerWidget(),
            SizedBox(height: 8.h,),
            loginBtnWidget(context),
            registerTextWidget(),
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

  SizedBox loginBtnWidget(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: ElevatedButton(
        onPressed: () {
          context.push('/login');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor
        ), 
        child: CustomTextWidget(
          text: 'Login',
          color: Colors.white,
          size: 14.sp,
        ),
      ),
    );
  }

  Expanded registrationStepContainerWidget() {
    return Expanded(
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          border: Border.all()
        ),
        padding: EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: '1. Sudah melakukan pembayaran pendaftaran',
              size: 14.sp,
            ),
            CustomTextWidget(
              text: '2. Melakukan pendaftaran di akun LPK',
              size: 14.sp,
            ),
            CustomTextWidget(
              text: '3. Upload Bukti Pembayaran',
              size: 14.sp,
            )
          ],
        ),
      ),
    );
  }

  CustomTextWidget titleWidget() {
    return CustomTextWidget(
      text: 'Alur pendaftaran akun LPK',
      size: 18.sp,
      weight: FontWeight.w500,
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      elevation: 0,
      leadingWidth: 65.w,
      centerTitle: false,
      leading: Row(
        children: [
          SizedBox(width: 8.w,),
          Image.asset('assets/images/logo.png')
        ],
      ),
      title: CustomTextWidget(
        text: 'Sipemik LPK',
        size: 24.sp,
        weight: FontWeight.bold,
      ),
    );
  }
}