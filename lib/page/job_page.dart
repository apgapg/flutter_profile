import 'package:flutter/material.dart';
import 'package:flutter_profile/widget/bottom_page_text.dart';

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
                  "I work at Flick2Know Technologies located in Gurugram, India, as a core team member in NPD Product.\nAs a FreeLancer, i am a Mobile App Developer expertise in Flutter Sdk.",
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
