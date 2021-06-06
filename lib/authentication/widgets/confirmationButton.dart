import 'package:flutter/material.dart';

class ConfirmationButton extends StatelessWidget {
  final String text;
  final bool loading;
  final void Function(BuildContext)? onPressed;
  const ConfirmationButton({
    required this.text,
    this.loading = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) onPressed!(context);
      },
      child: loading ? CircularProgressIndicator() : Text(text),
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
