import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/input_score_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/materi_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/student_bloc.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/column_title_and_textfield_widget.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/custom_textfield_widget.dart';
import 'package:siakad_lpk/features/register/presentation/widgets/custom_dropdown_btn_widget.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/custom_dialog_widget.dart';
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
        BlocProvider(
          create: (context) => sl<InputScoreBloc>(),
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
  String? studenDropdownValue;
  String? materiDropdownValue;

  final nilaiEditingController = TextEditingController();

  @override
  void dispose() {
    nilaiEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          materiBlocBuilderWidget(),
          SizedBox(height: 12.h,),
          studentBlocBuilderWidget(),
          SizedBox(height: 12.h,),
          inputNilaiBlocListenerWidget()
        ],
      ),
    );
  }

  BlocListener<InputScoreBloc, InputScoreState> inputNilaiBlocListenerWidget() {
    return BlocListener<InputScoreBloc, InputScoreState>(
      listener: (context, state) {
        if(state is InputScorSucceed){
          showDialog(
            context: context, 
            builder: (_) {
              return const CustomDialog(
                value: 'Berhail menambahkan nilai', 
                title: 'Berhasil'
              );
            }
          ).then((_) => context.pop());
        } else if (state is InputScoreFailed){
          context.pop();
          showDialog(
            context: context, 
            builder: (_) => ErrorDialog(errorValue: state.error.message!)
          );
        } else {
          showDialog(
            context: context, 
            builder: (_) => const LoadingDialog()
          );
        }
      },
      child: textFieldAndBtnRowWidget(),
    );
  }

  Row textFieldAndBtnRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width:.65.sw,
          child: ColumnTitleAndTextFieldWidget(
            textfield: CustomTextfieldWidget(
              controller: nilaiEditingController,
              hint: '',
            ), 
            title: 'Input nilai'
          ),
        ),
        SizedBox(
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {
              if(studenDropdownValue == null || 
                materiDropdownValue == null || 
                nilaiEditingController.text.isEmpty){
                showDialog(
                  context: context, 
                  builder: (_) => const ErrorDialog(
                    errorValue: 'form tidak boleh kosong'
                  )
                );
              } else {
                context.read<InputScoreBloc>().add(
                  PostInputScoreEvent(
                    idSiswa: studenDropdownValue!, 
                    idMateri: materiDropdownValue!, 
                    nilai: nilaiEditingController.text
                  )
                );
              }
            }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor
            ),
            child: CustomTextWidget(
              text: 'Simpan',
              size: 14.sp,
              weight: FontWeight.w500,
              color: Colors.white,
            )
          ),
        )
      ],
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
                studenDropdownValue = value!;
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
