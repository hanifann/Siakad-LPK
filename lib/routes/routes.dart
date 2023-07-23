import 'package:go_router/go_router.dart';
import 'package:siakad_lpk/features/landing/presentation/views/landing_view.dart';
import 'package:siakad_lpk/features/login/presentation/views/login_view.dart';
import 'package:siakad_lpk/features/register/presentation/views/register_view.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
  ],
);
