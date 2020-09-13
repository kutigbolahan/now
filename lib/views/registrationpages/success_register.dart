import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loginpage.dart';

class SuccessRegister extends StatefulWidget {
  @override
  _SuccessRegisterState createState() => _SuccessRegisterState();
}

class _SuccessRegisterState extends State<SuccessRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/appiconicon.png',
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Congratulations on successfully Registering.',
                  style: GoogleFonts.montserrat(
                      color: Color(0xff01A0C7),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'A confirmation link has been sent to the email provided,Click on the link and complete your registration and come back to login.',
                  style: GoogleFonts.montserrat(
                      color: Color(0xff01A0C7),
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Go back to login",
                    style: GoogleFonts.montserrat(
                        color: Color(0xff01A0C7),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
