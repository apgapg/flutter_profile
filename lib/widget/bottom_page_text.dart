import 'package:flutter/material.dart';

class BottomPageText extends StatelessWidget {
  final String text;

  BottomPageText(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            letterSpacing: 2.0,
            fontSize: 60.0,
            color: Colors.black.withOpacity(0.07),
          ),
        ),
      ),
    );
  }
}
