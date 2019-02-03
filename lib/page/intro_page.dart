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
                AnimatedCircularGlow(
                  endRadius: 120.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  repeatPause: Duration(milliseconds: 100),
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 60.0,
                    ),
                  ),
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
                SizedBox(height: 32.0,),
                AnimatedHello(),
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
  final bool repeat;
  final Duration duration;
  final double endRadius;

  final Duration repeatPause;

  final Widget child;

  AnimatedCircularGlow({this.endRadius, this.duration, this.repeat, this.repeatPause, @required this.child});

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
    controller = AnimationController(duration: widget.duration, vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = Tween(begin: (widget.endRadius * 2) / 6, end: (widget.endRadius * 2) * (3 / 4)).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    animation2 = Tween(begin: 0.0, end: (widget.endRadius * 2)).animate(curve)
      ..addListener(() {
        setState(() {});
      });

    alphaAnimation = Tween(begin: 0.30, end: 0.0).animate(controller);
    controller.addStatusListener((_) async {
      if (controller.status == AnimationStatus.completed) {
        await Future.delayed(widget.repeatPause);
        controller.reset();
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.endRadius * 2,
      width: widget.endRadius * 2,
      child: Stack(
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
          widget.child,
        ],
      ),
    );
  }
}

class AnimatedHello extends StatefulWidget {
  @override
  _AnimatedHelloState createState() => _AnimatedHelloState();
}

class _AnimatedHelloState extends State<AnimatedHello> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 1050), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = Tween(begin: 3.14 * 0.20, end: -3.14 * 0.20).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(milliseconds: 100));
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        await Future.delayed(Duration(milliseconds: 100));
        if (controller != null)
          controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animation.value,
      origin: Offset(0.0, 40.0),
      child: Container(
        height: 70.0,
        child: Image.asset(
          'assets/images/hand.png',
          height: 70.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
