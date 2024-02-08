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
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.add,
        color: Theme.of(context).hintColor,
      ),
    );
  }
}
