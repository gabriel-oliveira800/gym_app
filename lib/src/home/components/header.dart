import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../components/index.dart';
import '../home_controller.dart';
import 'avatar.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final HomeController controller;

  const Header({
    super.key,
    required this.controller,
  });

  @override
  Size get preferredSize => const Size.fromHeight(83);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20).copyWith(bottom: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _welcome(),
            const Spacing.horizontal(8),
            const ThemeToggle(),
          ],
        ),
      ),
    );
  }

  Widget _welcome() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Avatar(
          imageUrl: Strings.profileUrl,
        ),
        const Spacing.horizontal(12),
        ThemeWrapper(
          builder: (__, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTime.now().goodWithDate(),
                style: TextStyle(
                  fontSize: 16,
                  color: ThemeNotifier.whiteOrBlackColor(),
                ),
              ),
              Text(
                Strings.welcomeBack,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ThemeNotifier.whiteOrBlackColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
