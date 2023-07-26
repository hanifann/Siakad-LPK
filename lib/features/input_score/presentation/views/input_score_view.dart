import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/materi_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/student_bloc.dart';
import 'package:siakad_lpk/features/register/presentation/widgets/custom_dropdown_btn_widget.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class InputScoreView extends StatelessWidget {
  const InputScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<MateriBloc>()..add(GetMateriEvent()),
        ),
        BlocProvider(
          create: (context) => sl<StudentBloc>()..add(GetStudentEvent()),
        ),
      ],
      child: const InputScorePage(),
    );
  }
}

class InputScorePage extends StatefulWidget {
  const InputScorePage({super.key});

  @override
  State<InputScorePage> createState() => _InputScorePageState();
}

class _InputScorePageState extends State<InputScorePage> {
  late String studenDropdownValue;
  late String materiDropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          materiBlocBuilderWidget(),
          SizedBox(height: 12.h,),
          studentBlocBuilderWidget()
        ],
      ),
    );
  }

  BlocBuilder<StudentBloc, StudentState> studentBlocBuilderWidget() {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if(state is StudentLoaded){
          return CustomDropdownBtnWidget(
            hint: 'Pilih siswa',
            items: state.student.data.map<DropdownMenuItem<String>>((StudentData e) {
              return DropdownMenuItem<String>(
                value: e.idSiswa,
                child: CustomTextWidget(
                  text: e.fullName,
                )
              );
            }).toList(), 
            onChange: (String? value) {
              setState(() {
                materiDropdownValue = value!;
              });
            },
          );
        } else if (state is StudentFailed){
          return Text(state.error.message.toString());
        } else {
          return Shimmer.fromColors(
            baseColor: kSecondaryColor,
            highlightColor: kPrimaryColor,
            child: Container(
              width: 1.sw,
              height: 50.h,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  BlocBuilder<MateriBloc, MateriState> materiBlocBuilderWidget() {
    return BlocBuilder<MateriBloc, MateriState>(
      builder: (context, state) {
        if(state is MateriLoaded){
          return CustomDropdownBtnWidget(
            hint: 'Pilih materi',
            items: state.materi.data.map<DropdownMenuItem<String>>((MateriData e) {
              return DropdownMenuItem<String>(
                value: e.id,
                child: CustomTextWidget(
                  text: e.namaMateri,
                )
              );
            }).toList(), 
            onChange: (String? value) {
              setState(() {
                materiDropdownValue = value!;
              });
            },
          );
        } else if (state is MateriFailed){
          return Text(state.error.message.toString());
        } else {
          return Shimmer.fromColors(
            baseColor: kSecondaryColor,
            highlightColor: kPrimaryColor,
            child: Container(
              width: 1.sw,
              height: 50.h,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}
