import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/features/score/presentation/bloc/lpk_score_bloc.dart';
import 'package:siakad_lpk/features/score/presentation/bloc/score_bloc.dart';
import 'package:siakad_lpk/features/score/presentation/widgets/container_score_widget.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<ScoreBloc>()..add(GetTestScoreEvent())
          ),
          BlocProvider(
            create: (context) => sl<LpkScoreBloc>()..add(GetLpkScoreEvent()),
          ),
        ],
              child: const ScorePage(),
    );
  }
}

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: kPrimaryColor,
            labelPadding: EdgeInsets.only(bottom: 8.h),
            tabs: [
              CustomTextWidget(
                text: 'LPK',
                size: 14.sp,
                weight: FontWeight.w500,
              ),
              CustomTextWidget(
                text: 'Ujian',
                size: 14.sp,
                weight: FontWeight.w500,
              ),
            ]
          ),
        ),
        body: TabBarView(
          children: [
            lpkScpreBlocBuilderWidget(),
            testScpreBlocBuilderWidget()
          ],
        ),
      ),
    );
  }

  BlocBuilder<ScoreBloc, ScoreState> testScpreBlocBuilderWidget() {
    return BlocBuilder<ScoreBloc, ScoreState>(
      builder: (context, state) {
        if(state is TestScoreLoaded){
          return ListView.separated(
            padding: EdgeInsets.all(16.r),
            itemBuilder: (context, index) {
              return ContainerScoreWidget(
                nilai: state.testScore.data[index].nilUjian, 
                title: 'Nilai ujian'
              );
            }, 
            separatorBuilder: (_,__) => SizedBox(height: 12.h,),
            itemCount: state.testScore.data.length
          );
        } else if (state is TestScoreFailed){
          return Center(
            child: CustomTextWidget(
              text: state.error.message!,
              size: 14.sp,
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

  BlocBuilder<LpkScoreBloc, LpkScoreState> lpkScpreBlocBuilderWidget() {
    return BlocBuilder<LpkScoreBloc, LpkScoreState>(
      builder: (context, state) {
        if(state is LpkScoreLoaded){
          return ListView.separated(
            padding: EdgeInsets.all(16.r),
            itemBuilder: (context, index) {
              return ContainerScoreWidget(
                nilai: state.lpkScore.data[index].nilai, 
                title: state.lpkScore.data[index].namaMateri
              );
            }, 
            separatorBuilder: (_,__) => SizedBox(height: 12.h,),
            itemCount: state.lpkScore.data.length
          );
        } else if (state is LpkScoreFailed){
          return Center(
            child: CustomTextWidget(
              text: state.error.message!,
              size: 14.sp,
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
}