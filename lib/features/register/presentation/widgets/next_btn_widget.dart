import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class NextBtnWidget extends StatelessWidget {
  const NextBtnWidget({
    super.key, required this.onPressed, required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor
      ),
      child: Row(
        children: [
          CustomTextWidget(
            text: text,
            color: Colors.white,
            size: 14.sp,
          ),
          Visibility(
            visible: text == 'Selanjutnya' ? true : false,
            child: const Icon(
              Icons.navigate_next
            ),
          )
        ],
      )
    );
  }
}