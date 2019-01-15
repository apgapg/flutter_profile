import 'package:flutter/material.dart';
import 'package:flutter_profile/widget/bottom_page_text.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff686de0),
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      AnimatedCircularGlow(),
                      Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        color: Colors.transparent,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                          radius: 60.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  "Hi there!\n I am Ayush P Gupta",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.87),
                    fontWeight: FontWeight.w700,
                    fontSize: 28.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
          BottomPageText("Intro"),
        ],
      ),
    );
  }
}

class AnimatedCircularGlow extends StatefulWidget {
  @override
  _AnimatedCircularGlowState createState() => _AnimatedCircularGlowState();
}

class _AnimatedCircularGlowState extends State<AnimatedCircularGlow> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> animation2;
  Animation<double> alphaAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = Tween(begin: 40.0, end: 150.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    animation2 = Tween(begin: 0.0, end: 200.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    alphaAnimation = Tween(begin: 0.30, end: 0.0).animate(controller);
    controller.addStatusListener((_) async {
      if (controller.status == AnimationStatus.completed) {
        await Future.delayed(Duration(milliseconds: 100));
        controller.reset();
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: animation2.value,
          width: animation2.value,
          child: SizedBox(),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(alphaAnimation.value)),
        ),
        Container(
          height: animation.value,
          width: animation.value,
          child: SizedBox(),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(alphaAnimation.value)),
        ),
      ],
    );
  }
}
