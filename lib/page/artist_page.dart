import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_profile/widget/bottom_page_text.dart';

class ArtistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      color: Color(0xff576574),
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ImagesPageView(),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  "Tried little bit of sketching...",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.87), fontWeight: FontWeight.w700, fontSize: 24.0),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
          BottomPageText("Artist"),
        ],
      ),
    );
  }
}

class ImagesPageView extends StatefulWidget {
  @override
  ImagesPageViewState createState() {
    return new ImagesPageViewState();
  }
}

class ImagesPageViewState extends State<ImagesPageView> with TickerProviderStateMixin {
  final _pageController = new PageController();
  Animation<double> animation;
  Animation<double> linearAnimation;
  AnimationController controller;
  AnimationController controller1;

  StreamSubscription<int> periodicSub;

  bool _visible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = AnimationController(duration: Duration(milliseconds: 70), vsync: this);
    final Animation curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = Tween(begin: -70.0, end: 70.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    controller1 = AnimationController(duration: Duration(milliseconds: 1600), vsync: this);

    linearAnimation = Tween(begin: 0.0, end: MediaQuery.of(context).size.height / 1.5).animate(controller1);

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller1.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        controller.stop();
      }
    });
    startAnimation();
    
    /*  periodicSub = new Stream.periodic(const Duration(milliseconds: 2000), (v) => v).take(100).listen((count) {
      if (mounted) _pageController.nextPage(duration: Duration(milliseconds: 500), curve: ElasticInCurve());
    });*/
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Stack(
        children: <Widget>[
          ClipRect(
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                ImageWidget('assets/images/artist/i5.jpg'),
                ImageWidget(
                  'assets/images/artist/i2.jpg',
                ),
                ImageWidget(
                  'assets/images/artist/i3.jpg',
                ),
                ImageWidget(
                  'assets/images/artist/i4.jpg',
                ),
                ImageWidget(
                  'assets/images/artist/i1.jpg',
                ),
              ],
            ),
          ),
          _visible ? Transform.translate(
            offset: Offset(linearAnimation.value, linearAnimation.value),
            child: Transform.rotate(
              angle: -3.14 / 6,
              child: Transform.translate(
                offset: Offset(animation.value, 0),
                child: Image.asset(
                  'assets/images/pen.png',
                  height: MediaQuery.of(context).size.width / 4,
                ),
              ),
            ),
          ) : SizedBox(height: 0.0,),
        ],
      ),
    );
  }

  void startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _visible = true;
    });
    controller.forward();

    controller1.forward();
  }
}

class ImageWidget extends StatelessWidget {
  final String url;

  ImageWidget(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}
