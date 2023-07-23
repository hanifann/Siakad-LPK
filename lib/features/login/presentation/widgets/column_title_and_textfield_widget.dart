import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ColumnTitleAndTextFieldWidget extends StatelessWidget {
  const ColumnTitleAndTextFieldWidget({
    required this.textfield, 
    required this.title,
    this.size = 16,
    super.key,
  });

  final Widget textfield;
  final String title;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: title,
          weight: FontWeight.bold,
          size: size.sp,
        ),
        textfield
      ],
    );
  }
}
