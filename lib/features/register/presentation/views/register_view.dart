import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/column_title_and_textfield_widget.dart';
import 'package:siakad_lpk/features/login/presentation/widgets/custom_textfield_widget.dart';
import 'package:siakad_lpk/features/register/presentation/widgets/custom_dropdown_btn_widget.dart';
import 'package:siakad_lpk/features/register/presentation/widgets/next_btn_widget.dart';
import 'package:siakad_lpk/features/register/presentation/widgets/previous_btn_widget.dart';
import 'package:siakad_lpk/themes/colors.dart';
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
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  final pageViewController = PageController();

  DateTime date = DateTime.now();
  int pages = 0;
  bool isObscure = true;
  String? path;

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
    emailEditingController.dispose();
    passwordEditingController.dispose();
    pageViewController.dispose();
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
          SizedBox(
            width: 1.sw,
            height: 1.sh * 0.84,
            child: PageView(
              controller: pageViewController,
              children: [
                pageOneColumnWidget(),
                pageTwoColumnWidget(),
                pageThreeColumnWidget()
              ],
            ),
          ),
          SizedBox(height: 4.h,),
          navigationRowBtnWidget(),
          SizedBox(height: 14.h,),
          loginTextWidget(context)
        ],
      ),
    );
  }

  Column pageThreeColumnWidget() {
    return Column(
      children: [
        emailTextFieldWidget(),
        SizedBox(height: 12.h,),
        passwordTextFieldWidget(),
        SizedBox(height: 12.h,),
        filePickerTextFieldWidget()
      ],
    );
  }

  ColumnTitleAndTextFieldWidget filePickerTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.image
          );

          if (result != null) {
            File file = File(result.files.single.path!);
            setState(() {
              path = file.path;
            });
          } else {
            log('$result is empty');
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 56.h, horizontal: 8.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomTextWidget(
                  text: path == null ? 'Pilih file' : path!,
                  size: 16.sp,
                  weight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.description,
                size: 36.r,
              )
            ],
          ),
        ),
      ),
      title: 'Upload bukti pembayaran',
      isWithAsterisk: true,
      condition: 'Pastikan bukti pembayaran merupakan pembayaran pendaftaran.',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget passwordTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: passwordEditingController, 
        hint: '',
        isObscure: isObscure,
        onSuffixTap: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        suffixIcon: isObscure ? Icons.visibility_off : Icons.visibility,
      ), 
      title: 'Password',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget emailTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: emailEditingController, 
        hint: '',
        textInputType: TextInputType.emailAddress,
      ), 
      title: 'Email',
      size: 15,
    );
  }

  Column pageTwoColumnWidget() {
    return Column(
      children: [
        parentTextFieldWidget(),
        SizedBox(height: 12.h,),
        addressTextFieldWidget(),
        SizedBox(height: 12.h,),
        expTextFieldWidget(),
        SizedBox(height: 12.h,),
        phoneTextFieldWidget(),
        SizedBox(height: 12.h,),
        idTextFieldWidget(),
      ],
    );
  }

  Row navigationRowBtnWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: pages == 0 ? false : true,
          child: PreviousBtnWidget(
            onPressed:() {
              setState(() {
              pages--;
            });
              pageViewController.previousPage(
                duration: const Duration(milliseconds: 300), 
                curve: Curves.ease
              );
            },
          ),
        ),
        NextBtnWidget(
          onPressed: () {
            setState(() {
              pages++;
            });
            pageViewController.nextPage(
              duration: const Duration(milliseconds: 300), 
              curve: Curves.ease
            );
          },
        )
      ],
    );
  }

  ColumnTitleAndTextFieldWidget idTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: idEditingController, 
        hint: ''
      ), 
      title: 'No. KTP',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget phoneTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: phoneEditingController, 
        hint: '',
        textInputType: TextInputType.number,
      ), 
      title: 'No. Telephone',
      isWithAsterisk: true,
      condition: 'Pastikan no. telepon terhubung ke WhatsApp' 
      ' karena digunakan untuk info aktivasi akun',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget expTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: experienceEditingController, 
        hint: '',
        maxLines: 5,
      ), 
      title: 'Pengalaman kerja',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget addressTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: addressEditingController, 
        hint: '',
        maxLines: 5,
      ), 
      title: 'Alamat Lengkap',
      size: 15,
    );
  }

  ColumnTitleAndTextFieldWidget parentTextFieldWidget() {
    return ColumnTitleAndTextFieldWidget(
      textfield: CustomTextfieldWidget(
        controller: parentEditingController, 
        hint: ''
      ), 
      title: 'Nama Orang Tua',
      size: 15,
    );
  }

  Center loginTextWidget(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: kPrimaryTextColor
          ),
          children: [
            const TextSpan(
              text: 'Sudah punya akun? ',
              style: TextStyle(
                fontWeight: FontWeight.w500
              )
            ),
            TextSpan(
              text: 'Masuk',
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap= (){
                context.pushReplacement('/login');
              }
            ),
          ]
        )
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