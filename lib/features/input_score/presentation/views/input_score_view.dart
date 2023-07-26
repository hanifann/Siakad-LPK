import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/materi.dart';
import 'package:siakad_lpk/features/input_score/domain/entities/student.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/delete_score_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/get_score_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/input_score_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/materi_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/student_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/bloc/update_score_bloc.dart';
import 'package:siakad_lpk/features/input_score/presentation/widgets/container_studen_score_widget.dart';
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
        BlocProvider(
          create: (context) => sl<DeleteScoreBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<UpdateScoreBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetScoreBloc>(),
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
  bool isEdit = false;
  String? idNilai;

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
          inputNilaiBlocListenerWidget(),
          getNilaiBlocBuilderWidget(),
          deleteScoreBlocListenerWidget(),
          updateScoreBlocListenerWidget()
        ],
      ),
    );
  }

  BlocListener<UpdateScoreBloc, UpdateScoreState> updateScoreBlocListenerWidget() {
    return BlocListener<UpdateScoreBloc, UpdateScoreState>(
      listener: (context, state) {
        if(state is UpdateScoreSucceed){
          showDialog(
            context: context, 
            builder: (_) {
              return const CustomDialog(
                value: 'Berhail update nilai', 
                title: 'Berhasil'
              );
            }
          ).then((_) => context.pop());
          context.read<GetScoreBloc>().add(
            FetchScoreEvent(materiDropdownValue!)
          );
        } else if (state is UpdateScoreFailed){
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
      child: const SizedBox(),
    );
  }

  BlocListener<DeleteScoreBloc, DeleteScoreState> deleteScoreBlocListenerWidget() {
    return BlocListener<DeleteScoreBloc, DeleteScoreState>(
      listener: (context, state) {
        if(state is DeleteScoreDSucceed){
          showDialog(
            context: context, 
            builder: (_) {
              return const CustomDialog(
                value: 'Berhail menghapus nilai', 
                title: 'Berhasil'
              );
            }
          ).then((_) => context.pop());
          context.read<GetScoreBloc>().add(
            FetchScoreEvent(materiDropdownValue!)
          );
        } else if (state is DeleteScoreFailed){
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
      child: const SizedBox(),
    );
  }

  BlocBuilder<GetScoreBloc, GetScoreState> getNilaiBlocBuilderWidget() {
    return BlocBuilder<GetScoreBloc, GetScoreState>(
      builder: (context, state) {
        if(state is GetScoreLoaded){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: state.score.data[0].namaMateri,
                size: 16.sp,
                weight: FontWeight.w500,
              ),
              SizedBox(height: 4.h,),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return ConainerStudentScoreWidget(
                    student: state.score.data[index],
                    onEdit: () {
                      setState(() {
                        nilaiEditingController.text = state.score.data[index].nilai;
                        isEdit = true;
                        idNilai = state.score.data[index].id;
                        studenDropdownValue = state.score.data[index].idSiswa;
                      });
                    },
                    onDelete: () {
                      context.read<DeleteScoreBloc>().add(
                        DeleteNilai(state.score.data[index].id)
                      );
                    },
                  );
                }, 
                separatorBuilder: (_,__) => SizedBox(height: 12.h,), 
                itemCount: state.score.data.length
              )
            ],
          );
        } else if (state is GetScoreFailed){
          return Text(state.error.message!);
        } else if (state is GetScoreLoading){
          return Center(
            child: CircularProgressIndicator.adaptive(
              valueColor: const AlwaysStoppedAnimation(kPrimaryColor),
              backgroundColor: 
                Platform.isAndroid ? Colors.white : kPrimaryColor,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
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
          context.read<GetScoreBloc>().add(
            FetchScoreEvent(materiDropdownValue!)
          );
          setState(() {
            isEdit = false;
          });
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
                if(isEdit){
                  context.read<UpdateScoreBloc>().add(
                    UpdateNilaiEvent(
                      idNilai!,
                      studenDropdownValue!,
                      materiDropdownValue!,
                      nilaiEditingController.text
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
                ),
                onTap: () {
                  setState(() {
                    studenDropdownValue = e.idSiswa;
                  });
                },
              );
            }).toList(),
            value: studenDropdownValue,
            onChange: (String? value) {
              
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
              context.read<GetScoreBloc>().add(
                FetchScoreEvent(materiDropdownValue!)
              );
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
