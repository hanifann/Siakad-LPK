import 'package:go_router/go_router.dart';
import 'package:siakad_lpk/features/login/presentation/views/login_view.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginView(),
    ),
  ],
);
