import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/common_widgets/gradient_text_button.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/utils.dart';
import '../blocs/user_bloc/user_bloc.dart';
import '../cubits/recover_password_form/recover_password_form_cubit.dart';

class RecoverPasswordView extends StatelessWidget {
  const RecoverPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<RecoverPasswordFormCubit>(),
        child: Builder(
          builder: (context) {
            return BlocPresentationListener<UserBloc, UserEvent>(
              listener: (context, event) {
                if (event is UserErrorEvent) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(displayErrorSnackbar(event.message));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(smallSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Recover your password',
                      style: TextStyle(
                        color: textDark,
                        fontSize: xlText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    xlSeparator,
                    BlocBuilder<RecoverPasswordFormCubit,
                        RecoverPasswordFormState>(
                      buildWhen: (previous, current) {
                        return previous.email != current.email;
                      },
                      builder: (context, state) {
                        return TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your email...',
                            errorText: state.email.displayError?.errorMessage,
                          ),
                          onChanged: (final String value) => context
                              .read<RecoverPasswordFormCubit>()
                              .onEmailChanged(value),
                        );
                      },
                    ),
                    mediumSeparator,

                    //send email button
                    BlocBuilder<RecoverPasswordFormCubit,
                        RecoverPasswordFormState>(
                      builder: (context, state) {
                        return GradientElevatedButton(
                          onTap: () {
                            final isValidForm = context
                                .read<RecoverPasswordFormCubit>()
                                .validateForm();
                            if (isValidForm) {
                              context.read<UserBloc>().add(
                                    UserRecoverPasswordEvent(
                                      email: state.email.value,
                                    ),
                                  );
                            }
                          },
                          displayWidget: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              if (state is UserLoading) {
                                return const SizedBox(
                                  height: mediumSize,
                                  width: mediumSize,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                );
                              }
                              return const Text(
                                'Send email',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          gradient: buttonsGradientReversed,
                        );
                      },
                    ),
                    mediumSeparator,
                    GradientTextButton(
                      onTap: () {
                        context.go(AppRoutes.signin.path);
                      },
                      text: 'Sign in your account.',
                    ),
                    xsSeparator,
                    const Text('OR'),
                    xsSeparator,
                    GradientTextButton(
                      onTap: () {
                        context.go(AppRoutes.signup.path);
                      },
                      text: 'Create a new account.',
                      gradient: buttonsGradientReversed,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
