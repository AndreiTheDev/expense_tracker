import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/blocs/user_bloc/user_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            BlocProvider.of<UserBloc>(context).add(UserSignOutEvent());
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
