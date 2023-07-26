import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student_score.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ConainerStudentScoreWidget extends StatelessWidget {
  const ConainerStudentScoreWidget({super.key, required this.student, required this.onDelete, required this.onEdit});

  final StudentScoreData student;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: student.fullName,
                size: 16.sp,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
              CustomTextWidget(
                text: 'Nilai LPK ${student.nilai}',
                size: 16.sp,
                weight: FontWeight.bold,
                color: Colors.white,
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5.r)
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8.w,),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5.r)
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}