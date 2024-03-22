import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../../core/utils/utils.dart';
import '../blocs/user_bloc/user_bloc.dart';
import '../cubits/sign_up_form/sign_up_form_cubit.dart';
import '../widgets/sign_up_email_password.dart';
import '../widgets/sign_up_user_details.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpFormCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(smallSize),
          child: BlocBuilder<SignUpFormCubit, SignUpFormState>(
            builder: (context, state) {
              if (!state.isValidFirstStep) {
                return BlocPresentationListener<UserBloc, UserEvent>(
                  listener: (context, event) {
                    if (event is UserErrorEvent) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(displayErrorSnackbar(event.message));
                    }
                  },
                  child: const SignUpEmailPassword(),
                );
              }
              return BlocPresentationListener<UserBloc, UserEvent>(
                listener: (context, event) {
                  if (event is UserErrorEvent) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(displayErrorSnackbar(event.message));
                  }
                },
                child: const SignUpUserDetails(),
              );
            },
          ),
        ),
      ),
    );
  }
}
