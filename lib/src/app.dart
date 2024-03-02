import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../injection_container.dart';
import 'core/routing/app_router.dart';
import 'core/theme/theme.dart';
import 'features/authentication/presentation/blocs/user_bloc/user_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>()..add(UserStarted()),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserAuthenticated || state is UserUnauthenticated) {
            appRouter.refresh();
          }
        },
        child: MaterialApp.router(
          theme: lightTheme,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
