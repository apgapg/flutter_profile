import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile/page/about_page.dart';
import 'package:flutter_profile/page/artist_page.dart';
import 'package:flutter_profile/page/contact_page.dart';
import 'package:flutter_profile/page/intro_page.dart';
import 'package:flutter_profile/page/job_page.dart';
import 'package:flutter_profile/page/unacademy_page.dart';
import 'package:flutter_profile/utils.dart';
import 'package:flutter_profile/widget/navigation_button.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        fontFamily: 'Nunito',

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', analytics: analytics),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FirebaseAnalytics analytics;

  MyHomePage({Key key, this.title, this.analytics}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController controller = new PageController();

  @override
  void initState() {
    super.initState();

    _setAnalyticsCollectionEnabled();
  }

  Future<void> _setAnalyticsCollectionEnabled() async {
    await widget.analytics.android?.setAnalyticsCollectionEnabled(!isDebug);
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
                ArtistPage(),
                UnacademyPage(),
                ContactPage(),
              ],
              controller: controller,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TabsController(controller),
            )
          ],
        ),
      ),
    );
  }
}

class TabsController extends StatefulWidget {
  final PageController controller;

  TabsController(this.controller);

  @override
  TabsControllerState createState() {
    return new TabsControllerState();
  }
}

class TabsControllerState extends State<TabsController> {
  bool isUpButtonActive = false;

  bool isDownButtonActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUpButtonActive = false;
    isDownButtonActive = true;
    widget.controller.addListener(() {
      if (widget.controller.page == 0) {
        setState(() {
          isUpButtonActive = false;
          isDownButtonActive = true;
        });
      } else if (widget.controller.page == 5) {
        setState(() {
          isUpButtonActive = true;
          isDownButtonActive = false;
        });
      } else {
        setState(() {
          isUpButtonActive = true;
          isDownButtonActive = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  void onDownPress() {
    widget.controller.nextPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  void onUpPress() {
    widget.controller.previousPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }
}
