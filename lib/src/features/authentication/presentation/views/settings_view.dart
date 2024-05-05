import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common_widgets/custom_appbar.dart';
import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/utils/utils.dart';
import '../blocs/user_bloc/user_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.all(mediumSize),
              child: Column(
                children: [
                  xlSeparator,
                  CustomAppbar(
                    leftButton: CustomAppbarButton(
                      onTap: context.pop,
                      icon: isIos ? Icons.arrow_back_ios_new : Icons.arrow_back,
                    ),
                    middleWidget: const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: mediumText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  mediumSeparator,
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage: NetworkImage(user.photoUrl),
                    radius: xxlSize,
                  ),
                  mediumSeparator,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Actions',
                      style: TextStyle(
                        fontSize: smallHeaderText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  smallSeparator,
                  SettingsListTile(
                    text: 'Delete account',
                    icon: Icons.delete,
                    onTap: () {
                      context.read<UserBloc>().add(UserDeleteUserEvent());
                    },
                  ),
                  smallSeparator,
                  SettingsListTile(
                    text: 'Data Consent',
                    icon: Icons.verified_user,
                    onTap: () {},
                  ),
                  smallSeparator,
                  SettingsListTile(
                    text: 'Sign Out',
                    icon: Icons.arrow_circle_right,
                    onTap: () {
                      context.read<UserBloc>().add(UserSignOutEvent());
                    },
                  ),
                  mediumSeparator,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About',
                      style: TextStyle(
                        fontSize: smallHeaderText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  smallSeparator,
                  Row(
                    children: [
                      const Text('Author: '),
                      GestureDetector(
                        onTap: () async {
                          final url =
                              Uri.parse('https://github.com/AndreiTheDev');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) =>
                              buttonsGradient.createShader(
                            Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                          ),
                          child: const Text('AndreiTheDev'),
                        ),
                      ),
                    ],
                  ),
                  xsSeparator,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Version: 1.2.3'),
                  ),
                  xsSeparator,
                  Row(
                    children: [
                      const Text('Design: '),
                      GestureDetector(
                        onTap: () async {
                          final url = Uri.parse(
                            'https://dribbble.com/shots/15560984-Daily-Expense-Tracker',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) =>
                              buttonsGradient.createShader(
                            Rect.fromLTRB(0, 0, bounds.width, bounds.height),
                          ),
                          child: const Text('Dribble'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(mediumSize),
            child: SizedBox.expand(
              child: Column(
                children: [
                  xlSeparator,
                  CustomAppbar(
                    leftButton: CustomAppbarButton(
                      onTap: context.pop,
                      icon: isIos ? Icons.arrow_back_ios_new : Icons.arrow_back,
                    ),
                    middleWidget: const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: mediumText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  mediumSeparator,
                  const Expanded(
                    child: Center(
                      child: Text(
                        'An unknown error occured.',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    required this.text,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(xsSize),
      child: Ink(
        padding: const EdgeInsets.all(smallSize),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(xsSize),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffdddddd),
              offset: Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Icon(
              icon,
              color: iconButtonsColor,
            ),
          ],
        ),
      ),
    );
  }
}
