import 'package:flutter/material.dart';
import 'package:flutter_profile/widget/bottom_page_text.dart';
import 'package:url_launcher/url_launcher.dart';

class JobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      color: Color(0xff00a8ff),
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                /* Material(
                  elevation: 4.0,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/falogo.png',
                    height: 70.0,
                  ),
                ),*/
                AnimatedLaptop(),
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  "I work at Flick2Know Technologies located in Gurugram, India, as a core team member in NPD Product.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.87),
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0),
                ),
                SizedBox(
                  height: 32.0,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL("https://www.fieldassist.in/");
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "https://www.fieldassist.in/",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white.withOpacity(0.87),
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomPageText("My Job"),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class AnimatedLaptop extends StatefulWidget {
  @override
  _AnimatedLaptopState createState() => _AnimatedLaptopState();
}

class _AnimatedLaptopState extends State<AnimatedLaptop>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  bool showLogo = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = StepTween(begin: 0, end: 21).animate(curve);
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        setState(() {
          showLogo = true;
        });
        await Future.delayed(Duration(seconds: 1));
        controller.reset();
        controller.forward();
      } else if (status == AnimationStatus.forward) {
        setState(() {
          showLogo = false;
        });
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 68.0,
              alignment: Alignment.center,
              width: 40.0,
              margin: EdgeInsets.all(2.0),
              color: Colors.white,
              child: showLogo
                  ? Center(
                      child: Image.asset(
                        'assets/images/falogo.png',
                        height: 24.0,
                      ),
                    )
                  : Text(""),
            ),
            Image.asset(
              'assets/images/mobile.png',
              height: 90.0,
              width: 60.0,
            ),
          ],
        ),
        SizedBox(
          width: 4.0,
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: 68.0,
              alignment: Alignment.center,
              width: 110.0,
              margin: EdgeInsets.all(2.0),
              color: Colors.white,
              child: Text(
                "print('FieldAssist');".substring(0, animation.value),
                style: TextStyle(fontSize: 10.0),
              ),
            ),
            Image.asset(
              'assets/images/laptop.png',
              height: 100.0,
              width: 150.0,
            ),
          ],
        ),
      ],
    );
  }
}
