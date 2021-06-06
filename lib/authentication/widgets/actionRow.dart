import 'package:flutter/material.dart';

class ActionRow extends StatelessWidget {
  final String mainText;

  final String actionText;
  final VoidCallback? action;
  const ActionRow({
    required this.mainText,
    required this.actionText,
    this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(mainText),
        SizedBox(width: 3),
        TextButton(onPressed: action, child: Text(actionText))
      ],
    );
  }
}
