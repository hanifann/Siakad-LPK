import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:siakad_lpk/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:siakad_lpk/features/beranda/presentation/views/beranda_view.dart';
import 'package:siakad_lpk/features/input_score/presentation/views/input_score_view.dart';
import 'package:siakad_lpk/themes/colors.dart';
import 'package:siakad_lpk/widgets/text_widget.dart';

class HomeLecturerView extends StatelessWidget {
  const HomeLecturerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeLecturerPage();
  }
}

class HomeLecturerPage extends StatefulWidget {
  const HomeLecturerPage({super.key});

  @override
  State<HomeLecturerPage> createState() => _HomeLecturerPageState();
}

class _HomeLecturerPageState extends State<HomeLecturerPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    BerandaView(),
    InputScoreView()
  ];

  static const List<BottomNavigationBarItem> _bottomNavItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Nilai',
    ),
  ];

  static const List<String> _title = <String>[
    'Beranda',
    'Nilai',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.10),
              offset: const Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: _bottomNavItem,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          backgroundColor: kPrimaryColor,
          unselectedItemColor: Colors.white,
          // selectedItemColor: kPrimaryColor,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
        ),
      ),
    );
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: CustomTextWidget(
        text: _title[_selectedIndex],
        weight: FontWeight.bold,
        size: 24.sp,
      ),
      actions: [
        GestureDetector(
          onTap: () => context.push('/profile'),
          child: Container(
            padding: EdgeInsets.all(8.r),
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(666.r),
              color: kPrimaryColor,
            ),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if(state is AuthAuthenticated){
                  return CustomTextWidget(
                    text: state.user.fullName.split(' ').first,
                    color: Colors.white,
                    weight: FontWeight.bold,
                    size: 14.sp,
                  );
                } else {
                  return CustomTextWidget(
                    text: '...',
                    color: Colors.white,
                    weight: FontWeight.bold,
                    size: 14.sp,
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}