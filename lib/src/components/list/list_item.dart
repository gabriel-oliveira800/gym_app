import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../index.dart';

class ListItemStyle {
  final double radius;
  final EdgeInsets padding;

  const ListItemStyle({
    this.radius = 60,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });
}

class ListItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;
  final ListItemStyle style;
  final BoxConstraints constraints;

  const ListItem({
    super.key,
    this.onTap,
    required this.name,
    this.isSelected = false,
    this.style = const ListItemStyle(),
    this.constraints = const BoxConstraints(maxHeight: 32),
  });

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (mode, theme) {
        final bgColor = switch (isSelected) {
          true => ThemeNotifier().colorByMode(
              AppColors.categoryBgActive,
              AppColors.categoryBgDisable,
            ),
          _ => ThemeNotifier().colorByMode(
              AppColors.categoryBgDisable,
              AppColors.categoryBgActive,
            ),
        };

        final textColor = switch (isSelected) {
          true => ThemeNotifier().colorByMode(
              AppColors.categoryTextActive,
              AppColors.categoryTextDisable,
            ),
          _ => ThemeNotifier().colorByMode(
              AppColors.categoryTextDisable,
              AppColors.categoryTextActive,
            ),
        };

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(style.radius),
          child: AnimatedContainer(
            padding: style.padding,
            constraints: constraints,
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(style.radius),
            ),
            alignment: Alignment.center,
            child: AutoSizeText(
              name,
              maxLines: 1,
              minFontSize: 8,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
