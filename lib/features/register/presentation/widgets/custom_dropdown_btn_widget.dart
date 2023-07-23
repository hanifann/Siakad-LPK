import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/themes/colors.dart';

class CustomDropdownBtnWidget extends StatelessWidget {
  const CustomDropdownBtnWidget({
    super.key, 
    required this.items, 
    required this.onChange
  });
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: items,
      onChanged: onChange,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        border: InputBorder.none,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryTextColor,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}