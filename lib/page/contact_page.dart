import 'package:flutter/material.dart';
import 'package:flutter_profile/widget/bottom_page_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  var color = Color(0xffee5253);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      color: Color(0xffee5253),
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      child: Icon(
                        Icons.phone,
                        color: color,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "+91-8218135689",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      child: Icon(
                        Icons.mail,
                        color: color,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "ayushpguptaapg@gmail.com",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                SizedBox(
                  height: 64.0,
                ),
                Row(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        _launchURL("https://medium.com/@ayushpguptaapg");
                      },
                      mini: true,
                      child: Icon(
                        FontAwesomeIcons.mediumM,
                        color: color,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.9),
                    ),
                    HorizontalSpacing(),
                    FloatingActionButton(
                      onPressed: () {
                        _launchURL("https://www.instagram.com/ayushpgupta/");
                      },
                      mini: true,
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        color: color,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.9),
                    ),
                    HorizontalSpacing(),
                    FloatingActionButton(
                      onPressed: () {
                        _launchURL("https://github.com/apgapg");
                      },
                      mini: true,
                      child: Icon(
                        FontAwesomeIcons.github,
                        color: color,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.9),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        _launchURL("https://www.facebook.com/ayushpgupta");
                      },
                      mini: true,
                      child: Icon(
                        FontAwesomeIcons.facebookF,
                        color: color,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.9),
                    ),
                    HorizontalSpacing(),
                    FloatingActionButton(
                      onPressed: () {
                        _launchURL("https://medium.com/@ayushpguptaapg");
                      },
                      mini: true,
                      child: Icon(
                        FontAwesomeIcons.googlePlusG,
                        color: color,
                      ),
                      backgroundColor: Colors.white.withOpacity(0.9),
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                SizedBox(
                  height: 64.0,
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL("https://about.me/ayushpgupta");
                  },
                  child: Text(
                    "https://about.me/ayushpgupta",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomPageText("Contact"),
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

class _AnimatedLaptopState extends State<AnimatedLaptop> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  bool showLogo = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.linear);
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

class HorizontalSpacing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.0,
    );
  }
}
