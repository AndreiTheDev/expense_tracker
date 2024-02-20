import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../../core/utils/utils.dart';
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
        body: Padding(
          padding: const EdgeInsets.all(smallSize),
          child: BlocBuilder<SignUpFormCubit, SignUpFormState>(
            builder: (context, state) {
              if (!state.isValidFirstStep) {
                return const SignUpEmailPassword();
              }
              return const SignUpUserDetails();
            },
          ),
        ),
      ),
    );
  }
}
