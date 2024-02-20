import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/common_widgets/gradient_text.dart';
import '../../../../core/utils/utils.dart';
import '../cubits/profile_photos_urls/profile_photos_urls_cubit.dart';
import '../cubits/sign_up_form/sign_up_form_cubit.dart';

class SignUpUserDetails extends StatefulWidget {
  const SignUpUserDetails({super.key});

  @override
  State<SignUpUserDetails> createState() => _SignUpUserDetailsState();
}

class _SignUpUserDetailsState extends State<SignUpUserDetails> {
  late final TextEditingController _completeNameController;

  @override
  void initState() {
    super.initState();
    _completeNameController = TextEditingController();
  }

  @override
  void dispose() {
    _completeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        xlSeparator,
        Align(
          alignment: Alignment.centerLeft,
          child: CustomAppbarButton(
            onTap: () {
              context.read<SignUpFormCubit>().invalidateFirstStep();
            },
            icon: Icons.arrow_back,
          ),
        ),
        mediumSeparator,
        const GradientText(
          text: "Let's setup your profile",
          fontSize: textMedium,
        ),
        mediumSeparator,
        BlocProvider(
          create: (context) => sl<ProfilePhotosUrlsCubit>(),
          child: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (final BuildContext innerContext) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: context.read<ProfilePhotosUrlsCubit>()
                              ..fetchProfilePhotosUrls(),
                          ),
                          BlocProvider.value(
                            value: context.read<SignUpFormCubit>(),
                          ),
                        ],
                        child: const ProfilePhotosBottomSheet(),
                      );
                    },
                  );
                },
                child: SizedBox(
                  height: 128,
                  width: 128,
                  child: BlocBuilder<SignUpFormCubit, SignUpFormState>(
                    buildWhen: (previous, current) =>
                        previous.photoUrl != current.photoUrl,
                    builder: (context, state) {
                      return CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: state.photoUrl.isNotEmpty
                            ? NetworkImage(state.photoUrl)
                            : null,
                        child: state.photoUrl.isEmpty
                            ? const Icon(Icons.photo_camera)
                            : null,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        mediumSeparator,
        BlocBuilder<SignUpFormCubit, SignUpFormState>(
          builder: (context, state) {
            _completeNameController.value = _completeNameController.value
                .copyWith(text: state.completeName.value);
            return TextField(
              controller: _completeNameController,
              decoration: InputDecoration(
                hintText: 'Enter your complete name...',
                errorText: state.completeName.displayError?.errorMessage,
                errorMaxLines: 2,
              ),
              onChanged: (final String value) =>
                  context.read<SignUpFormCubit>().onCompleteNameChanged(value),
            );
          },
        ),
        mediumSeparator,
        GradientElevatedButton(
          onTap: () {
            context.read<SignUpFormCubit>().isFormValid();
          },
          displayWidget: const Text(
            'Create Profile',
            style: TextStyle(color: Colors.white),
          ),
          gradient: buttonsGradientReversed,
        ),
      ],
    );
  }
}

class ProfilePhotosBottomSheet extends StatelessWidget {
  const ProfilePhotosBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(mediumSize)),
        gradient: backgroundGradient,
      ),
      height: 600,
      width: double.maxFinite,
      child: BlocBuilder<ProfilePhotosUrlsCubit, ProfilePhotosUrlsState>(
        builder: (context, state) {
          if (state is ProfilePhotosUrlsInitial ||
              state is ProfilePhotosUrlsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (state is ProfilePhotosUrlsLoaded) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return GridView.count(
                  padding: const EdgeInsets.all(smallSize),
                  mainAxisSpacing: smallSize,
                  crossAxisSpacing: smallSize,
                  crossAxisCount: constraints.maxWidth > 280 ? 3 : 2,
                  children: [
                    for (final item in state.urls)
                      GestureDetector(
                        onTap: () {
                          context
                              .read<SignUpFormCubit>()
                              .onPhotoUrlChanged(item);
                          context.pop();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(item),
                        ),
                      ),
                  ],
                );
              },
            );
          }
          return Center(
            child: Text(
              state is ProfilePhotosUrlsError
                  ? state.message
                  : 'An unknown error occured.',
              style: const TextStyle(color: Colors.white, fontSize: textMedium),
            ),
          );
        },
      ),
    );
  }
}
