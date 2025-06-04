import 'package:flutter/material.dart';

import '../src/components/index.dart';
import 'strings.dart';

typedef OnTryAgain = void Function(VoidCallback? onDismiss);

abstract class Utils {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  static void onDismiss() => scaffoldKey.currentState?.hideCurrentSnackBar();

  static void errorToast(String message, {OnTryAgain? onTryAgain}) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        showCloseIcon: onTryAgain == null,
        content: Row(
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
            ),
            const Spacing.horizontal(8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            if (onTryAgain != null)
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: () => onTryAgain(onDismiss),
              ),
          ],
        ),
      ),
    );
  }

  static int getWeekday() => DateTime.now().weekday;

  static List<String> getShortWeekdays() => List.generate(
        DateTime.daysPerWeek,
        (index) => Strings.shortWeekdays[index + 1] ?? '',
      );
}
