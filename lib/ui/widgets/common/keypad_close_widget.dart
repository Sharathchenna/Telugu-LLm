import 'package:flutter/material.dart';

class CloseKeyPadWidget extends StatelessWidget {
  final Widget child;
  const CloseKeyPadWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
