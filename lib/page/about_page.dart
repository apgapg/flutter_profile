import 'package:flutter/material.dart';
import 'package:flutter_profile/widget/bottom_page_text.dart';

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
