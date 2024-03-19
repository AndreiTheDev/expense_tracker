import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/blocs/user_bloc/user_bloc.dart';
import '../../features/authentication/presentation/views/recover_password_view.dart';
import '../../features/authentication/presentation/views/sign_in_view.dart';
import '../../features/authentication/presentation/views/sign_up_view.dart';
import '../../features/home/presentation/views/add_transactions_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../common_views/splash_view.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.splash.path,
      name: AppRoutes.splash.name,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SplashView()),
    ),
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.home.name,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeView()),
      routes: [
        GoRoute(
          path: AppRoutes.addTransactions.path,
          name: AppRoutes.addTransactions.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AddTransactionsView(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.signin.path,
      name: AppRoutes.signin.name,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SignInView()),
    ),
    GoRoute(
      path: AppRoutes.signup.path,
      name: AppRoutes.signup.name,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SignUpView()),
    ),
    GoRoute(
      path: AppRoutes.recoverPassword.path,
      name: AppRoutes.recoverPassword.name,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: RecoverPasswordView()),
    ),
  ],
  initialLocation: '/',
  redirect: (context, state) {
    final userState = context.read<UserBloc>().state;

    final bool isAuthFlow = state.matchedLocation == AppRoutes.signin.path ||
        state.matchedLocation.startsWith(AppRoutes.signup.path) ||
        state.matchedLocation == AppRoutes.recoverPassword.path;

    final bool isHomeFlow =
        state.matchedLocation.startsWith(AppRoutes.home.path);

    if (userState is UserUnauthenticated) {
      return isAuthFlow ? null : AppRoutes.signin.path;
    }
    if (userState is UserAuthenticated) {
      return isHomeFlow ? null : AppRoutes.home.path;
    }
    return null;
  },
);
