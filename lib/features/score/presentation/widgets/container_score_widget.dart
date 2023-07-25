import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ContainerScoreWidget extends StatelessWidget {
  const ContainerScoreWidget({super.key, required this.nilai, required this.title});
  final String nilai;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: const Offset(0, 4),
            color: kPrimaryColor.withOpacity(.15)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            text: title,
            size: 16.sp,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
          CustomTextWidget(
            text: nilai,
            size: 16.sp,
            weight: FontWeight.bold,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}