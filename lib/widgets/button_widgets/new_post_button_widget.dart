import 'package:flutter/material.dart';

class NewPostButtonWidget extends StatelessWidget {
  const NewPostButtonWidget({super.key, required this.onFloatingButtonPressed});

  final Function() onFloatingButtonPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onFloatingButtonPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.black,
      child: const Icon(Icons.add),
    );
  }
}
