import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../components/index.dart';

class FabActionsButton extends StatefulWidget {
  final VoidCallback onCategory;
  final VoidCallback onExercise;

  const FabActionsButton({
    super.key,
    required this.onCategory,
    required this.onExercise,
  });

  @override
  State<FabActionsButton> createState() => _FabActionsButtonState();
}

class _FabActionsButtonState extends State<FabActionsButton>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;

  late final Animation<double> _animation;
  late final AnimationController _controller;

  static const _duration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _toggleMenu() {
    setState(() => isOpen = !isOpen);
    isOpen ? _controller.forward() : _controller.reverse();
  }

  void _onCategory() {
    widget.onCategory();
    _toggleMenu();
  }

  void _onExercise() {
    widget.onExercise();
    _toggleMenu();
  }

  @override
  Widget build(BuildContext context) {
    const double size = 56.0;
    const double spacing = 12.0;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        AnimatedPositioned(
          right: 0,
          duration: _duration,
          bottom: isOpen.useValue((size + spacing), 0),
          child: ScaleTransition(
            scale: _animation,
            child: _fabButton(
              icon: Svgs.createCategory,
              onPressed: _onCategory,
            ),
          ),
        ),
        AnimatedPositioned(
          right: 0,
          duration: _duration,
          bottom: isOpen.useValue((size * 2) + spacing, 0),
          child: ScaleTransition(
            scale: _animation,
            child: _fabButton(
              icon: Svgs.createExercise,
              onPressed: _onExercise,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: _mainFabButton(),
        ),
      ],
    );
  }

  Widget _fabButton({
    required String icon,
    required VoidCallback onPressed,
  }) {
    const size = Size.square(20);

    return ThemeWrapper(
      builder: (_, __) => FloatingActionButton(
        mini: true,
        onPressed: onPressed,
        backgroundColor: ThemeNotifier().colorByMode(
          AppColors.fabBgColor,
          Colors.white,
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(
            ThemeNotifier.blackOrWhiteColor(),
            BlendMode.srcIn,
          ),
          width: size.width,
          height: size.height,
        ),
      ),
    );
  }

  Widget _mainFabButton() {
    return ThemeWrapper(
      builder: (_, __) => FloatingActionButton(
        onPressed: _toggleMenu,
        backgroundColor: ThemeNotifier().colorByMode(
          AppColors.fabBgColor,
          Colors.white,
        ),
        child: TweenAnimationBuilder(
          duration: _duration,
          tween: isOpen.tween(0, 1),
          builder: (context, value, child) => Transform.rotate(
            angle: value * 3.14,
            child: Icon(
              isOpen.useValue(Icons.close, Icons.add),
              color: ThemeNotifier.blackOrWhiteColor(),
            ),
          ),
        ),
      ),
    );
  }
}
