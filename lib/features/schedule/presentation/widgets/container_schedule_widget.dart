import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/features/schedule/domain/entities/schedule.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ContainerScheduleWidget extends StatelessWidget {
  const ContainerScheduleWidget({super.key, required this.scheduleData});

  final ScheduleData scheduleData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(.20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextWidget(
            text: scheduleData.namaMateri,
            size: 16.sp,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
          Row(
            children: [
              CustomTextWidget(
                text: scheduleData.dari,
                size: 14.sp,
                color: Colors.white,
                weight: FontWeight.w500,
              ),
              CustomTextWidget(
                text: '-',
                size: 14.sp,
                color: Colors.white,
                weight: FontWeight.w500,
              ),
              CustomTextWidget(
                text: scheduleData.sampai,
                size: 14.sp,
                color: Colors.white,
                weight: FontWeight.w500,
              ),
            ],
          )
        ],
      ),
    );
  }
}