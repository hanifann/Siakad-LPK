import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/features/score/presentation/bloc/score_bloc.dart';
import 'package:siakad_lpk/features/score/presentation/widgets/container_score_widget.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ScoreView extends StatelessWidget {
  const ScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ScoreBloc>()
        ..add(GetLpkScoreEvent()),
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
              ]),
        ),
        body: TabBarView(
          children: [
            lpkScoreBlocBuilder(),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }

  BlocConsumer<ScoreBloc, ScoreState> lpkScoreBlocBuilder() {
    return BlocConsumer<ScoreBloc, ScoreState>(
      listener: (context, state) {
        if(state is LpkScoreLoaded){
          context.read<ScoreBloc>().add(GetTestScoreEvent());
        }
      },
      builder: (context, state) {
        return BlocBuilder<ScoreBloc, ScoreState>(
          builder: (context, state) {
            if (state is LpkScoreLoaded) {
              return ListView.separated(
                padding: EdgeInsets.all(16.r),
                itemBuilder: (context, index) {
                  return ContainerScoreWidget(
                    nilai: state.lpkScore.data[index].nilai,
                    title: state.lpkScore.data[index].namaMateri
                  );
                },
                separatorBuilder: (_, __) => SizedBox(
                  height: 12.h,
                ),
                itemCount: state.lpkScore.data.length);
            } else if (state is LpkScoreFailed) {
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
      },
    );
  }
}
