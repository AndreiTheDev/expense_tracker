import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../../core/utils/utils.dart';
import '../blocs/user_bloc/user_bloc.dart';
import '../cubits/delete_account_form/delete_account_form_cubit.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  bool isPasswordObscured = true;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return BlocProvider<DeleteAccountFormCubit>(
      create: (context) => sl(),
      child: Dialog(
        child: Container(
          padding: const EdgeInsets.all(smallSize),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(mediumSize),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to delete your account?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: mediumText),
              ),
              smallSeparator,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: smallSize),
                child: Text(
                  'This action is permanent. We need your password for confirmation.',
                  textAlign: TextAlign.center,
                ),
              ),
              mediumSeparator,
              BlocBuilder<DeleteAccountFormCubit, DeleteAccountFormState>(
                buildWhen: (previous, current) {
                  return previous.password != current.password;
                },
                builder: (context, state) {
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
                    ),
                    obscureText: isPasswordObscured,
                    onChanged: (final String value) => context
                        .read<DeleteAccountFormCubit>()
                        .onPasswordChanged(value),
                  );
                },
              ),
              mediumSeparator,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: isIos
                    ? [
                        const DeleteButton(),
                        const CancelButton(),
                      ]
                    : [
                        const CancelButton(),
                        const DeleteButton(),
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteAccountFormCubit, DeleteAccountFormState>(
      builder: (context, state) {
        return OutlinedButton(
          onPressed: () {
            final isFormValid =
                context.read<DeleteAccountFormCubit>().validateForm();
            if (isFormValid) {
              context
                  .read<UserBloc>()
                  .add(UserDeleteUserEvent(password: state.password.value));
              context.pop();
            }
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide.none,
            foregroundColor: const Color(0xfff9c8c8),
            backgroundColor: errorColor.withOpacity(0.7),
          ),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: context.pop,
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
        foregroundColor: const Color(0xffceebd4),
        backgroundColor: successColor.withOpacity(0.7),
      ),
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
