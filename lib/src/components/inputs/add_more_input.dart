import 'package:flutter/material.dart';

import 'number_editing_controller.dart';

class AddMoreInput extends StatelessWidget {
  final String hint;
  final NumberEditingController controller;

  const AddMoreInput({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onTap: () => {},
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: AnimatedBuilder(
          animation: controller,
          builder: (_, __) => _actionButton(isAdd: false),
        ),
        suffixIcon: _actionButton(),
      ),
    );
  }

  Widget _actionButton({bool isAdd = true}) {
    final isMax = controller.isMax;

    return IconButton(
      icon: Icon(isAdd ? Icons.add : Icons.remove),
      onPressed: switch (isMax && !isAdd) {
        true => null,
        _ => isAdd ? controller.increment : controller.decrement
      },
    );
  }
}
