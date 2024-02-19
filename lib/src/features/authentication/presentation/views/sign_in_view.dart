import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/common_widgets/gradient_text_button.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/utils.dart';
import '../blocs/user_bloc/user_bloc.dart';
import '../cubits/sign_in_form/sign_in_form_cubit.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<SignInFormCubit>(),
        child: Builder(
          builder: (context) {
            return BlocListener<UserBloc, UserState>(
              listenWhen: (previous, current) => current is UserError,
              listener: (context, state) {
                if (state is UserError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(smallSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: textDark,
                        fontSize: textXl,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    xlSeparator,

                    //Email text field
                    BlocBuilder<SignInFormCubit, SignInFormState>(
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
                              .read<SignInFormCubit>()
                              .onEmailChanged(value),
                        );
                      },
                    ),
                    mediumSeparator,

                    //Password text field
                    BlocBuilder<SignInFormCubit, SignInFormState>(
                      buildWhen: (previous, current) {
                        return previous.password != current.password;
                      },
                      builder: (context, state) {
                        return TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your password...',
                            errorText:
                                state.password.displayError?.errorMessage,
                            errorMaxLines: 2,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordObscured = !isPasswordObscured;
                                });
                              },
                              icon: ShaderMask(
                                shaderCallback: (bounds) =>
                                    buttonsGradient.createShader(bounds),
                                blendMode: BlendMode.srcIn,
                                child: Icon(
                                  isPasswordObscured
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            border: DecoratedInputBorder(
                              shadow: const [
                                GradientShadow(
                                  gradient: buttonsGradientReversed,
                                  blurRadius: 14,
                                  spreadRadius: -4,
                                ),
                              ],
                              child: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          obscureText: isPasswordObscured,
                          onChanged: (final String value) => context
                              .read<SignInFormCubit>()
                              .onPasswordChanged(value),
                        );
                      },
                    ),
                    mediumSeparator,

                    //sign in button
                    BlocBuilder<SignInFormCubit, SignInFormState>(
                      builder: (context, state) {
                        return GradientElevatedButton(
                          onTap: () {
                            final isFormValid =
                                context.read<SignInFormCubit>().validateForm();
                            if (isFormValid) {
                              context.read<UserBloc>().add(
                                    UserSignInEvent(
                                      email: state.email.value,
                                      password: state.password.value,
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
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    mediumSeparator,
                    GradientTextButton(
                      onTap: () {
                        context.go(AppRoutes.recoverPassword.path);
                      },
                      text: 'Recover your password.',
                      gradient: buttonsGradientReversed,
                    ),
                    xsSeparator,
                    const Text('OR'),
                    xsSeparator,
                    GradientTextButton(
                      onTap: () {
                        context.go(AppRoutes.signup.path);
                      },
                      text: 'Create a new account.',
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
