import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/controllers/auth/auth.dart';
import 'package:nahere/views/registrationpages/emailcode.dart';

import 'package:nahere/views/registrationpages/loginpage.dart';

import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String email;
  TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Box<String> feedsBox;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    feedsBox = Hive.box<String>("feedsApp");
    // print(feedsBox);
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      var data = {
        'email_address': _emailController.text,
      };

      try {
        var response = await Provider.of<CallApi>(context, listen: false)
            .postData(data, 'user/forgot_password');
        var body = jsonDecode(response.body);
        if (body['msg'] == 'Ok') {
          final val = _emailController.text;
          feedsBox.put('email', val);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => EmailCodePasswordReset()),
              (route) => false);
        } else {
          _showToast(context, body['msg']);
        }
        setState(() {
          _isLoading = false;
        });

        print(body);
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        return _showToast(
            context, 'Please check your internet connection and try again!!!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/appiconicon.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    TextFormField(
                      validator: EmailValidator.validate,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        // icon: Icon(Icons.message),
                        labelText: 'Email*',
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      onSaved: (input) => email = input,
                    ),
                  ]),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '*A code will be sent to your email',
                        style: GoogleFonts.montserrat(fontSize: 10),
                      ),
                    ]),
                SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? CircularProgressIndicator(
                        // backgroundColor: Colors.grey,
                        strokeWidth: 1.5,
                      )
                    : RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        color: Color(0xff01A0C7),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.montserrat(fontSize: 15),
                          ),
                        ),
                        onPressed: _isLoading ? null : _submit),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Back to Login",
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showToast(BuildContext context, msg) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(),
      content: Text(
        msg,
        style: GoogleFonts.montserrat(fontSize: 12),
      ),
      duration: Duration(seconds: 5),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
