import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/common_widgets/gradient_text_button.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/utils.dart';
import '../cubits/sign_up_form/sign_up_form_cubit.dart';

class SignUpEmailPassword extends StatefulWidget {
  const SignUpEmailPassword({super.key});

  @override
  State<SignUpEmailPassword> createState() => _SignUpEmailPasswordState();
}

class _SignUpEmailPasswordState extends State<SignUpEmailPassword> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isPasswordObscured = true;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: textXl,
            color: textDark,
          ),
          textAlign: TextAlign.center,
        ),
        xlSeparator,
        BlocBuilder<SignUpFormCubit, SignUpFormState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) {
            _emailController.value =
                _emailController.value.copyWith(text: state.email.value);
            return TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email...',
                errorMaxLines: 2,
                errorText: state.email.displayError?.errorMessage,
              ),
              onChanged: (final String value) =>
                  context.read<SignUpFormCubit>().onEmailChanged(value),
            );
          },
        ),
        mediumSeparator,
        BlocBuilder<SignUpFormCubit, SignUpFormState>(
          buildWhen: (previous, current) =>
              previous.password != current.password,
          builder: (context, state) {
            _passwordController.value =
                _passwordController.value.copyWith(text: state.password.value);
            return TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password...',
                errorText: state.password.displayError?.errorMessage,
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
              onChanged: (final String value) =>
                  context.read<SignUpFormCubit>().onPasswordChanged(value),
            );
          },
        ),
        mediumSeparator,
        GradientElevatedButton(
          onTap: () async {
            context.read<SignUpFormCubit>().isValidFirstStep();
          },
          displayWidget: const Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        mediumSeparator,
        GradientTextButton(
          onTap: () async {
            context.go(AppRoutes.signin.path);
          },
          text: 'Sign in your account.',
          gradient: buttonsGradientReversed,
        ),
        xsSeparator,
        const Text('OR'),
        xsSeparator,
        GradientTextButton(
          onTap: () {
            context.go(AppRoutes.recoverPassword.path);
          },
          text: 'Recover your password.',
        ),
      ],
    );
  }
}
