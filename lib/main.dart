import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile/page/about_page.dart';
import 'package:flutter_profile/page/artist_page.dart';
import 'package:flutter_profile/page/contact_page.dart';
import 'package:flutter_profile/page/intro_page.dart';
import 'package:flutter_profile/page/job_page.dart';
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
                ArtistPage(),
                ContactPage(),
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
