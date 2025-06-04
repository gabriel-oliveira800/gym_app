import 'package:flutter/material.dart';
import '../../../shared/index.dart';

import '../../../shared/states/index.dart';
import '../index.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(ThemeNotifier.blackOrWhiteColor()),
    );
  }
}

class LoadingSwitcher extends StatelessWidget {
  final Widget child;
  final InLoading state;

  const LoadingSwitcher({
    super.key,
    required this.state,
    this.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return StateOfBuilder<bool>(
      state: state,
      builder: (isLoading) => AnimatedSwitcher(
        duration: 300.duration,
        child: isLoading ? const Loading() : child,
      ),
    );
  }
}
