import 'package:flutter/material.dart';
import 'package:flutter_profile/widget/bottom_page_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UnacademyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2e86de),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Material(
                elevation: 8.0,
                shape: CircleBorder(),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/unacademy.png',
                    height: 150,
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomRow(Icons.credit_card, "course", 22),
                  Space(),
                  CustomRow(Icons.personal_video, "videos", 37),
                  Space(),
                  CustomRow(FontAwesomeIcons.thumbsUp, "likes", 1813),
                  Space(),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Rating(),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "IIT-JEE Physics Educator at Unacademy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.87),
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              GestureDetector(
                onTap: () {
                  _launchURL("https://unacademy.com/user/ayushpgupta");
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    "https://unacademy.com/user/ayushpgupta",
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
              SizedBox(
                height: 24.0,
              ),
            ],
          ),
          BottomPageText("Teaching"),
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

class CustomRow extends StatefulWidget {
  final IconData iconData;
  final String text;

  final int endValue;

  CustomRow(this.iconData, this.text, this.endValue);

  @override
  CustomRowState createState() {
    return new CustomRowState();
  }
}

class CustomRowState extends State<CustomRow>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = StepTween(begin: 0, end: widget.endValue).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            widget.iconData,
            color: Colors.white.withOpacity(0.9),
          ),
          SizedBox(
            width: 16.0,
          ),
          Text(
            animation.value.toString() + " " + widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontWeight: FontWeight.w700,
                fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  void startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    controller.forward();
  }
}

class Space extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.0,
    );
  }
}

class Rating extends StatefulWidget {
  @override
  RatingState createState() {
    return new RatingState();
  }
}

class RatingState extends State<Rating> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  bool isComplete = false;

  final _list = [
    "assets/images/unacademy/1.png",
    "assets/images/unacademy/2.png",
    "assets/images/unacademy/3.png",
    "assets/images/unacademy/4.png",
  ];

  final _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 8000), vsync: this);

    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0, end: 580.0).animate(curve);
    controller.addStatusListener((_) async {
      if (controller.status == AnimationStatus.completed) {
        if (controller != null) {
          controller.reverse();
        }
      } else if (controller.status == AnimationStatus.dismissed) {
        if (controller != null) controller.forward();
      }
    });
    controller.addListener(() {
      _scrollController.jumpTo(animation.value);
    });

    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                child: Image.asset(
                  _list.elementAt(index),
                ),
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: _list.length,
      ),
    );
  }

  void startAnimation() async {
    await Future.delayed(Duration(milliseconds: 1400));
    controller.forward();
  }
}
