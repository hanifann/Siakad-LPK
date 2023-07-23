import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class PreviousBtnWidget extends StatelessWidget {
  const PreviousBtnWidget({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor
      ),
      child: Row(
        children: [
          const Icon(
            Icons.navigate_before
          ),
          CustomTextWidget(
            text: 'Kembali',
            color: Colors.white,
            size: 14.sp,
          ),
        ],
      )
    );
  }
}