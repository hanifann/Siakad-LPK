import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siakad_lpk/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:siakad_lpk/features/home_lecturer/presentation/views/home_lecturer_view.dart';
import 'package:siakad_lpk/features/home_student/presentation/views/home_student_view.dart';
import 'package:siakad_lpk/features/landing/presentation/views/landing_view.dart';
import 'package:siakad_lpk/injection_container.dart';
import 'package:siakad_lpk/themes/colors.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>()..checkAuthenticationStatus(),
      child: const AuthPage(),
    );
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          if (state.user.role == '2') {
            return BlocProvider.value(
              value: context.read<AuthCubit>(),
              child: const HomeStudentView(),
            );
          } else {
            return BlocProvider.value(
              value: context.read<AuthCubit>(),
              child: const HomeLecturerView(),
            );
          }
        } else if (state is AuthUnauthorized) {
          return const LandingView();
        } else {
          return Scaffold(
            body: SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: const Center(
                  child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(kPrimaryColor),
              )),
            ),
          );
        }
      },
    );
  }
}
