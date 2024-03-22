import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/utils/utils.dart';
import '../../../authentication/presentation/blocs/user_bloc/user_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserAuthenticated) {
          final user = state.user;
          return Padding(
            padding: const EdgeInsets.only(
              left: mediumSize,
              right: mediumSize,
              top: mediumSize,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  backgroundImage: NetworkImage(
                    user.photoUrl,
                  ),
                ),
                smallSeparator,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: smallText,
                      ),
                    ),
                    Text(
                      user.completeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                CustomAppbarButton(
                  onTap: () {},
                  icon: Icons.mode_standby,
                ),
              ],
            ),
          );
        }
        return const Text('An unknown error occured.');
      },
    );
  }
}

//this widget will not be used yet, app design and logic seems better without it
class HomeAppBarLoading extends StatelessWidget {
  const HomeAppBarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.only(
          left: mediumSize,
          right: mediumSize,
          top: mediumSize,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
            ),
            smallSeparator,
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: smallText,
                  ),
                ),
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            CustomAppbarButton(
              onTap: () {},
              icon: Icons.mode_standby,
            ),
          ],
        ),
      ),
    );
  }
}
