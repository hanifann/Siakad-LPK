import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:siakad_lpk/features/schedule/domain/entities/day.dart';
import 'package:siakad_lpk/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:siakad_lpk/features/schedule/presentation/widgets/container_day_widget.dart';
import 'package:siakad_lpk/features/schedule/presentation/widgets/container_schedule_widget.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ScheduleBloc>()..add(GetScheduleEvent()),
      child: const SchedulePage(),
    );
  }
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Day> day = [
    Day(
      day: 'Senin',
    ),
    Day(
      day: 'Selasa',
    ),
    Day(
      day: 'Rabu',
    ),
    Day(
      day: 'Kamis',
    ),
    Day(
      day: 'Jumat',
    ),
    Day(
      day: 'Sabtu',
    ),
    Day(
      day: 'Minggu',
    ),
  ];

  @override
  void initState() {
    final now = DateFormat('EEEE', 'id').format(DateTime.now());
    day.where((element) => element.day == now).map((e) => e.isSelected = true).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        children: [
          dayListViewWidget(),
          SizedBox(height: 16.h,),
          scheduleBlocBuilderWidget()
        ],
      ),
    );
  }

  BlocBuilder<ScheduleBloc, ScheduleState> scheduleBlocBuilderWidget() {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if(state is ScheduleLoaded){
          return ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              String temp = day.where((element) => element.isSelected == true).first.day;
              return ContainerScheduleWidget(
                scheduleData: state.schedule.data.where((element) => element.hari == temp).first
              );
            }, 
            separatorBuilder: (_,__) => SizedBox(height: 8.h,), 
            itemCount: state.schedule.data.where(
              (element) => element.hari == day.where(
                (element) => element.isSelected == true
              ).first.day
            ).length
          );
        } else if (state is ScheduleFailed){
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

  SizedBox dayListViewWidget() {
    return SizedBox(
      height: 34.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                for (final element in day) {
                  element.isSelected = false;
                }
                day[index].isSelected = true;
              });
            },
            child: ContainerDayWidget(
              day: day[index]
            ),
          );
        }, 
        separatorBuilder: (_,__) => SizedBox(width: 12.w,), 
        itemCount: day.length
      ),
    );
  }
}
