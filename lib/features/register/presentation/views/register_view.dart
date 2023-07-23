import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/column_title_and_textfield_widget.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/custom_textfield_widget.dart';
import 'package:siakad_lpk/features/register/presentation/widgets/custom_dropdown_btn_widget.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const RegisterPage();
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fullNameEditingController = TextEditingController();
  final pobEditingController = TextEditingController();
  final dobEditingController = TextEditingController();
  final lastEduEditingController = TextEditingController();
  final parentEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final experienceEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final idEditingController = TextEditingController();
  DateTime date = DateTime.now();

  List<String> marriageStatusLists = [
    'Belum kawin',
    'Kawin',
    'Cerai hidup',
    'Cerai mati'
  ];

  List<String> religionList = [
    'Islam',
    'Kristen Protestan',
    'Kristen Katolik',
    'Hindu',
    'Buddha',
    'Khonghucu'
  ];

  late String marriageStatus;
  late String religion;

  @override
  void dispose() {
    fullNameEditingController.dispose();
    pobEditingController.dispose();
    dobEditingController.dispose();
    lastEduEditingController.dispose();
    parentEditingController.dispose();
    addressEditingController.dispose();
    experienceEditingController.dispose();
    phoneEditingController.dispose();
    idEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        children: [
          titleWidget(),
          SizedBox(height: 16.h,),
          pageOneColumnWidget()
        ],
      ),
    );
  }

  Column pageOneColumnWidget() {
    return Column(
      children: [
        fullNameTextFieldWidget(),
        SizedBox(height: 12.h,),
        pobTextFieldWidget(),
        SizedBox(height: 12.h,),
        dobTextFieldWidget(),
        SizedBox(height: 12.h,),
        lastEduTextFieldWidget(),
        SizedBox(height: 12.h,),
        marriageTextFieldWidget(),
        SizedBox(height: 12.h,),
        religionTextFieldWidget()
      ],
    );
  }

  ColumnTitleAndTextFieldWidget religionTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomDropdownBtnWidget(
        items: religionList.map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        ).toList(),
        onChange: (value) {
          setState(() {
            religion = value!;
          });
        },
      ),
      title: 'Agama',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget marriageTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomDropdownBtnWidget(
        items: marriageStatusLists.map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ),
        ).toList(),
        onChange: (value) {
          setState(() {
            marriageStatus = value!;
          });
        },
      ),
      title: 'Status',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget lastEduTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: lastEduEditingController, 
        hint: ''
      ), 
      title: 'Pendidikan terakhir',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget pobTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: pobEditingController, 
        hint: ''
      ), 
      title: 'Tempat lahir',
      size: 15,
    );
  }

  GestureDetector dobTextFieldWidget() {
    return GestureDetector(
      onTap: () => showDatePicker(
        context: context, 
        firstDate: DateTime(1900), 
        lastDate: DateTime(2100),
        initialDate: DateTime.now(),
        locale: const Locale('id', 'ID')
      ).then((value) {
        setState(() {
          date = value ?? date;
          dobEditingController.text = DateFormat('MM/dd/yyyy', 'id')
            .format(date);
        });
      }),
      child: ColumnTitleAndTextFieldWidget(
        textfield: CustomTextfieldWidget(
          controller: dobEditingController, 
          hint: '',
          isEnabled: false,
        ), 
        title: 'Tempat lahir',
        size: 15,
      ),
    );
  }

  ColumnTitleAndTextFieldWidget fullNameTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: fullNameEditingController, 
        hint: ''
      ), 
      title: 'Nama lengkap',
      size: 15,
    );
  }

  Center titleWidget() {
    return Center(
      child: CustomTextWidget(
        text: 'Isi data dibawah ini',
        size: 24.sp,
        weight: FontWeight.w600,
      ),
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      elevation: 0,
      leadingWidth: 65.w,
      centerTitle: false,
      leading: Row(
        children: [
          SizedBox(width: 8.w,),
          Image.asset('assets/images/logo.png')
        ],
      ),
      title: CustomTextWidget(
        text: 'Sipemik LPK',
        size: 24.sp,
        weight: FontWeight.bold,
      ),
    );
  }
}