import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:siakad_lpk/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:siakad_lpk/features/profile/presentation/widgets/row_profile_data_widget.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/error_widget.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfileEvent()),
      child: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if(state is ProfileLoaded){
            return profileLoadedWidget(state, context);
          } else if (state is ProfileFailed){
            return CustomErrorWidget(message: state.error.message!);
          } else {
            return const SizedBox();
          }
        },
      )
    );
  }

  Widget profileLoadedWidget(ProfileLoaded state, BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.r),
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(.15),
                blurRadius: 8.0
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: 'Informasi Pengguna',
                weight: FontWeight.bold,
                size: 16.sp,
              ),
              SizedBox(height: 8.h,),
              RowProfileDataWidget(
                title: 'Nama',
                value: state.user.fullName,
              ),
              SizedBox(height: 4.h,),
              RowProfileDataWidget(
                title: 'Role',
                value: idToRole(state.user.role),
              ),
              SizedBox(height: 4.h,),
              RowProfileDataWidget(
                title: 'Email',
                value: state.user.email,
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(.15),
                blurRadius: 10
              ),
            ],
            borderRadius: BorderRadius.circular(8.r)
          ),
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if(state is LogoutSuccess){
                context.pushReplacement('/');
              }
            },
            child: ElevatedButton(
              onPressed: (){
                context.read<ProfileBloc>().add(LogoutEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0
              ), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: 'Keluar',
                    size: 14.sp,
                    weight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  const Icon(
                    Icons.logout,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 18.h,)
      ],
    );
  }

  AppBar appbarWidget() {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      title: CustomTextWidget(
        text: 'Profile',
        weight: FontWeight.bold,
        size: 24.sp,
      ),
    );
  }

  String idToRole(String id){
    if(id == '2'){
      return 'Pelajar';
    } else {
      return 'Pengajar';
    }
  }
}

