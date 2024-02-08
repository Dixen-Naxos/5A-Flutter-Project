import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: widget.controller,
          obscureText: isPasswordHidden,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Mot de passe",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Center(
                child: IconButton(
                  onPressed: _showPassword,
                  icon: const Icon(Icons.remove_red_eye),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _showPassword() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }
}
