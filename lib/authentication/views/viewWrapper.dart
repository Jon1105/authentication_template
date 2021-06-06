import 'package:flutter/material.dart';

class ViewWrapper extends StatelessWidget {
  final Widget child;
  const ViewWrapper(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(20),
      child: ConstrainedBox(
        child: child,
        constraints: BoxConstraints(maxWidth: 600),
      ),
    );
  }
}
