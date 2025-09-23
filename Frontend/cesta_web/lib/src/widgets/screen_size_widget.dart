import 'package:flutter/material.dart';

class ScreenSizeWidget extends StatelessWidget {
  final Widget child;

  const ScreenSizeWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 1300,
          padding: screenWidth > 800
              ? const EdgeInsets.only(left: 16, right: 16, top: 50)
              : EdgeInsets.only(left: 16, right: 16),
          margin: EdgeInsets.only(bottom: 16),
          child: child,
        ),
      ),
    );
  }
}
