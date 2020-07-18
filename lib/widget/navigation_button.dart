import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final IconData icon;

  VoidCallback onTapCallback;

  final bool isEnabled;

  NavigationButton(
      {@required this.icon,
      @required this.onTapCallback,
      @required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 24.0,
          color: Colors.white.withOpacity(
            isEnabled ? 0.9 : 0.3,
          ),
        ),
        onPressed: onTapCallback,
      ),
    );
  }
}
