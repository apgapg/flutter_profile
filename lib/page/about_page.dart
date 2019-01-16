import 'package:flutter/material.dart';
import 'package:flutter_profile/widget/bottom_page_text.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      color: Color(0xff00BFA5),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedTranslate(),
              SizedBox(
                height: 32.0,
              ),
              Text(
                //   "I’m from Lucknow. I’m an Android and Flutter developer at Flick2Know Technologies, Gurugram, India. Entrepreneurship, technology, and the most important DIY are my key interests. Besides this, i'm also an educator of Physics for IITJEE at Unacadmey. ",
                "I'm from Lucknow", textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.87), fontWeight: FontWeight.w700, fontSize: 28.0),
              ),
              SizedBox(
                height: 32.0,
              ),
              AnimatedHeritage(),
            ],
          ),
          BottomPageText("Home"),
        ],
      ),
    );
  }
}

class AnimatedHeritage extends StatefulWidget {
  @override
  _AnimatedHeritageState createState() => _AnimatedHeritageState();
}

class _AnimatedHeritageState extends State<AnimatedHeritage> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  bool show = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = Tween(begin: 3.14 * 0.20, end: -3.14 * 0.20).animate(curve);
    controller.addStatusListener((_) async {
      if (controller.status == AnimationStatus.completed) {
        setState(() {
          show = !show;
        });
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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: 40.0,
          width: 100.0,
          color: show ? Colors.red : Colors.yellow,
          margin: EdgeInsets.only(bottom: 4.0),
        ),
        Image.asset(
          'assets/images/lucknow_heritage.png',
          height: 120.0,
        ),
      ],
    );
  }
}

class AnimatedTranslate extends StatefulWidget {
  @override
  _AnimatedTranslateState createState() => _AnimatedTranslateState();
}

class _AnimatedTranslateState extends State<AnimatedTranslate> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  bool show = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = Tween(begin: 0.0, end: -30.0).animate(curve);
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
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
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/lucknow.png',
          height: 160.0,
        ),
        Transform.translate(
          offset: Offset(0.0, animation.value - 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Material(
                shape: CircleBorder(),
                color: Colors.white,

                child: Container(
                  padding: EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    radius: 20.0,
                  ),
                ),
              ),
              Icon(
                Icons.location_on,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
