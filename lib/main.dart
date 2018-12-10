import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile/widget/navigation_button.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        fontFamily: 'Nunito',

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController controller = new PageController();

  bool isUpButtonActive = false;

  bool isDownButtonActive = false;

  @override
  void initState() {
    super.initState();
    isUpButtonActive = false;
    isDownButtonActive = true;
    controller.addListener(() {
      print(controller.page);
      if (controller.page == 0) {
        setState(() {
          isUpButtonActive = false;
          isDownButtonActive = true;
        });
      } else if (controller.page == 1) {
        setState(() {
          isUpButtonActive = true;
          isDownButtonActive = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                IntroPage(),
                AboutPage(),
                JobPage(),
              ],
              controller: controller,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    NavigationButton(
                      icon: Icons.keyboard_arrow_up,
                      onTapCallback: onUpPress,
                      isEnabled: isUpButtonActive,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    NavigationButton(
                      icon: Icons.keyboard_arrow_down,
                      onTapCallback: onDownPress,
                      isEnabled: isDownButtonActive,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onDownPress() {
    controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  void onUpPress() {
    controller.previousPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }
}

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
                Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    radius: 60.0,
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Text(
                  "Hi there!\n I am Ayush P Gupta",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.87), fontWeight: FontWeight.w700, fontSize: 28.0),
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

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      color: Color(0xffeb4d4b),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              "I’m from Lucknow. I’m an Android and Flutter developer at Flick2Know Technologies, Gurugram, India. Entrepreneurship, technology, and the most important DIY are my key interests. Besides this, i'm also an educator of Physics for IITJEE at Unacadmey. ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withOpacity(0.87), fontWeight: FontWeight.w700, fontSize: 24.0),
            ),
          ),
          BottomPageText("About"),
        ],
      ),
    );
  }
}

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
                Material(
                  elevation: 4.0,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/falogo.png',
                    height: 70.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Currently I work at Flick2Know Technologies, Gurugram, India. FieldAssist is the flagship SaaS platform from Flick2Know Technologies used by more than 200 brands worldwide helping them increase their sales efficiency and productivity with the use of mobility.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.87), fontWeight: FontWeight.w700, fontSize: 24.0),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
          BottomPageText("My Job"),
        ],
      ),
    );
  }
}

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
