import 'package:flutter/material.dart';

import '../../../shared/states/index.dart';
import '../index.dart';

class Button extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final Size fixedSize;
  final Size? minimumSize;
  final VoidCallback? onPressed;

  final BoolState? inLoading;

  const Button({
    super.key,
    this.inLoading,
    this.minimumSize,
    required this.text,
    this.isEnabled = true,
    this.fixedSize = _size,
    required this.onPressed,
  });

  static const Size _size = Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          fixedSize: fixedSize,
          minimumSize: minimumSize ?? fixedSize,
          backgroundColor: ThemeNotifier.whiteOrBlackColor(),
          foregroundColor: ThemeNotifier.blackOrWhiteColor(),
        ),
        child: switch (inLoading) {
          InLoading it => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: LoadingSwitcher(state: it, child: _text()),
            ),
          _ => _text(),
        },
      ),
    );
  }

  Widget _text() {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}
