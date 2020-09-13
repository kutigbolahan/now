import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nahere/controllers/auth/sessions_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Sessions()),
                    (route) => false);
              },
              child: Text(
                'Skip',
                style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff01A0C7)),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                  image: 'assets/images/social2.png',
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent),
              makePage(

                  //reverse: true,
                  image: 'assets/images/collab.png',
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    makePage(
                        image: 'assets/images/join.png',
                        title: Strings.stepThreeTitle,
                        content: Strings.stepThreeContent),
                    Container(
                      width: 200,
                      child: RaisedButton(
                        color: Color(0xff01A0C7),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        child: Text('Get Started',
                            style: GoogleFonts.montserrat(fontSize: 13)),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sessions()),
                              (route) => false);
                        },
                      ),
                    ),
                  ]),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, color, reverse = false, button}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff01A0C7)),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 13, fontWeight: FontWeight.w300, color: Colors.grey),
          ),
          reverse
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: isActive ? Color(0xff01A0C7) : Colors.black12,
          borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

class Strings {
  static var stepOneTitle = "Corporate Social Network";
  static var stepOneContent =
      "Share business and work updates with your followers.";
  static var stepTwoTitle = "Collaboration";
  static var stepTwoContent =
      "Create work groups within your company organizations or social courses.";
  static var stepThreeTitle = "Join";
  static var stepThreeContent = "Create an account, login and start.";
}
