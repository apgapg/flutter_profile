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
                Center(
                  child: Text("gupta"),
                ),
              ],
              controller: controller,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: null,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      mini: true,
                      child: Icon(Icons.keyboard_arrow_up,color: Color(0xff686de0),),
                    ),
                    FloatingActionButton(
                      onPressed: onDownPress,
                      mini: true,
                      backgroundColor: Colors.white.withOpacity(0.6),
                      child: Icon(Icons.keyboard_arrow_down,color: Color(0xff686de0),),
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
    controller.animateToPage(2,duration: Duration(milliseconds: 500),curve: ElasticInOutCurve());
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
