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
                Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    radius: 44.0,
                  ),
                ),
                SizedBox(
                  height: 28.0,
                ),
                Row(
                  children: <Widget>[
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
                    CircularButton(FontAwesomeIcons.mediumM,
                        "https://medium.com/@ayushpguptaapg"),
                    HorizontalSpacing(),
                    CircularButton(FontAwesomeIcons.instagram,
                        "https://www.instagram.com/ayushpgupta/"),
                    HorizontalSpacing(),
                    CircularButton(
                        FontAwesomeIcons.github, "https://github.com/apgapg"),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: <Widget>[
                    CircularButton(FontAwesomeIcons.facebookF,
                        "https://www.facebook.com/ayushpgupta"),
                    HorizontalSpacing(),
                    CircularButton(FontAwesomeIcons.googlePlusG,
                        "https://medium.com/@ayushpguptaapg"),
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

class CircularButton extends StatefulWidget {
  final IconData iconData;

  final String url;

  CircularButton(this.iconData, this.url);

  @override
  CircularButtonState createState() {
    return new CircularButtonState();
  }
}

class CircularButtonState extends State<CircularButton>
    with SingleTickerProviderStateMixin {
  final Color color = Color(0xffee5253);
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    animation = Tween(begin: 4.0, end: 0.0).animate(curve);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(seconds: 1));
        if (controller != null) {
          controller.reset();
          controller.forward();
        }
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: animation.value),
      height: 40.0,
      child: FloatingActionButton(
        onPressed: () {
          _launchURL(widget.url);
        },
        mini: true,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: animation.value),
          child: Icon(
            widget.iconData,
            color: color,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
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
