import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/features/schedule/domain/entities/day.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ContainerDayWidget extends StatelessWidget {
  const ContainerDayWidget({super.key, required this.day});

  final Day day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: day.isSelected ? kSecondaryColor : const Color.fromRGBO(208, 208, 208, 1),
        border: Border.all(
          color:  kSecondaryColor
        )
      ),
      child: CustomTextWidget(
        text: day.day,
        color: day.isSelected ? Colors.white : kSecondaryColor,
        size: 14.sp,
      ),
    );
  }
}