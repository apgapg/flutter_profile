import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {
    super.initState();
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
              ],
              controller: controller,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: onUpPress,
                      backgroundColor: Colors.white.withOpacity(0.7),
                      mini: true,
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Color(0xff686de0),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    FloatingActionButton(
                      onPressed: onDownPress,
                      mini: true,
                      backgroundColor: Colors.white.withOpacity(0.7),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff686de0),
                      ),
                    )
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
      child: Center(
        child: Text(
          "Hi there!\n I am Ayush P Gupta",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.87), fontWeight: FontWeight.w700, fontSize: 28.0),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      color: Color(0xff22a6b3),
      child: Center(
        child: Text(
          "I’m from Lucknow. I’m an Android and Flutter developer at Flick2Know Technologies, Gurugram, India. Entrepreneurship, technology, and the most important DIY are my key interests. Besides this, i'm also an educator of Physics for IITJEE at Unacadmey. ",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.87), fontWeight: FontWeight.w700, fontSize: 24.0),
        ),
      ),
    );
  }
}
