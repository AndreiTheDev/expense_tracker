import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../bloc/user_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>()..add(UserStarted()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          print(state);
          if (state is UserUnauthenticated) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 48),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextField(
                    decoration:
                        InputDecoration(hintText: 'Enter your email...'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const TextField(
                    decoration:
                        InputDecoration(hintText: 'Enter your password...'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(
                        const UserSignInEvent(
                          email: 'emanuel@gmail.com',
                          password: 'Qazwsxedc99!',
                        ),
                      );
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            );
          }
          if (state is UserError) {
            return Text(state.message);
          }
          if (state is UserAuthenticated) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(UserSignOutEvent());
                },
                child: const Text('Sign Out'),
              ),
            );
          }
          return Placeholder();
        },
      ),
    );
  }
}
