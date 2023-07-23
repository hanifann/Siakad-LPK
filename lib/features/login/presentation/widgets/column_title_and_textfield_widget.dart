import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/themes/colors.dart';

class ColumnTitleAndTextFieldWidget extends StatelessWidget {
  const ColumnTitleAndTextFieldWidget({
    required this.textfield, 
    required this.title,
    this.size = 16,
    this.isWithAsterisk = false,
    this.condition,
    super.key,
  });

  final Widget textfield;
  final String title;
  final int size;
  final bool isWithAsterisk;
  final String? condition;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(),
        SizedBox(height: 4.h,),
        textfield,
        SizedBox(height: 4.h,),
        conditionTextWidget()
      ],
    );
  }

  RichText conditionTextWidget() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.sp,
          color: kPrimaryTextColor
        ),
        children: [
          WidgetSpan(
            child: Visibility(
              visible: isWithAsterisk ? true : false,
              child: Transform.translate(
                offset: const Offset(2, -4),
                child: Text(
                  '* ',
                  //superscript is usually smaller in size
                  textScaleFactor: 0.9,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          TextSpan(
            text: condition,
            style: TextStyle(
              fontSize: 12.sp
            )
          ),
        ]
      )
    );
  }

  RichText titleWidget() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.sp,
          color: kPrimaryTextColor
        ),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.sp
            )
          ),
          WidgetSpan(
            child: Visibility(
              visible: isWithAsterisk ? true : false,
              child: Transform.translate(
                offset: const Offset(2, -4),
                child: Text(
                  '*',
                  //superscript is usually smaller in size
                  textScaleFactor: 0.9,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          )
        ]
      )
    );
  }
}
