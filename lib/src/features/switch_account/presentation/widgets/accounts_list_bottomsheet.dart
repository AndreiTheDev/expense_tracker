import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/utils/utils.dart';
import '../../../authentication/presentation/blocs/user_bloc/user_bloc.dart';
import '../bloc/switch_account_bloc.dart';
import '../cubit/add_account_form_cubit.dart';

class CreateAccountBottomSheet extends StatefulWidget {
  const CreateAccountBottomSheet({super.key});

  @override
  State<CreateAccountBottomSheet> createState() =>
      _CreateAccountBottomSheetState();
}

class _CreateAccountBottomSheetState extends State<CreateAccountBottomSheet> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddAccountFormCubit>(
      create: (context) => sl(),
      child: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(mediumSize),
            child: Column(
              children: [
                const Text(
                  'Create new account',
                  style: TextStyle(
                    fontSize: mediumText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                mediumSeparator,
                BlocBuilder<AddAccountFormCubit, AddAccountFormState>(
                  buildWhen: (previous, current) =>
                      previous.name != current.name,
                  builder: (context, state) {
                    _nameController.value =
                        _nameController.value.copyWith(text: state.name.value);
                    return TextField(
                      controller: _nameController,
                      onChanged: (final String value) => context
                          .read<AddAccountFormCubit>()
                          .onNameChanged(value),
                      decoration: InputDecoration(
                        hintText: 'Account name...',
                        errorText: state.name.displayError?.errorMessage,
                      ),
                    );
                  },
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                GradientElevatedButton(
                  onTap: () {
                    final userState =
                        context.read<UserBloc>().state as UserAuthenticated;
                    final isValidForm =
                        context.read<AddAccountFormCubit>().validateForm();
                    if (isValidForm) {
                      context.read<SwitchAccountBloc>().add(
                            SwtichAccountCreateAccountEvent(
                              accountEntity: context
                                  .read<AddAccountFormCubit>()
                                  .state
                                  .toAccountEntity(
                                    userState.user.uid,
                                    userState.user.completeName,
                                  ),
                            ),
                          );
                      context.pop();
                    }
                  },
                  displayWidget: const Text(
                    'Create',
                    style: TextStyle(
                      color: textLight,
                    ),
                  ),
                ),
                smallSeparator,
              ],
            ),
          );
        },
      ),
    );
  }
}
