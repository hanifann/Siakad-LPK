import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/features/beranda/presentation/bloc/information_bloc.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class BerandaView extends StatelessWidget {
  const BerandaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InformationBloc>()..add(GetInformationEvent()),
      child: const BerandaPage(),
    );
  }
}

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        children: [
          imageWidget(),
          SizedBox(height: 16.h,),
          lpkTextWidget(),
          SizedBox(height: 16.h,),
          informationBlocBuilderWidget()
        ],
      ),
    );
  }

  BlocBuilder<InformationBloc, InformationState> informationBlocBuilderWidget() {
    return BlocBuilder<InformationBloc, InformationState>(
      builder: (context, state) {
        if(state is InformationLoaded){
          return Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return CustomTextWidget(
                  text: '${index+1}. ${state.information.information[index].konten}'
                );
              }, 
              separatorBuilder: (_,__) => SizedBox(height: 8.h,), 
              itemCount: state.information.information.length
            ),
          );
        } else if (state is InformationFailed){
          return Center(
            child: CustomTextWidget(
              text: state.error.message!,
              size: 16.sp,
              weight: FontWeight.w500,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: const AlwaysStoppedAnimation(kPrimaryColor),
              backgroundColor: 
                Platform.isAndroid ? Colors.white : kPrimaryColor,
            ),
          );
        }
      },
    );
  }

  CustomTextWidget lpkTextWidget() {
    return CustomTextWidget(
      text: 'Sipemik LPK',
      size: 18.sp,
      weight: FontWeight.w600,
      textAlign: TextAlign.center,
    );
  }

  Image imageWidget() {
    return Image.asset(
      'assets/images/logo.png',
      height: 128.r,
      width: 128.r,
    );
  }
}
