import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/controllers/auth/auth.dart';
import 'package:provider/provider.dart';

import 'loginpage.dart';

class RetypePassword extends StatefulWidget {
  @override
  _RetypePasswordState createState() => _RetypePasswordState();
}

class _RetypePasswordState extends State<RetypePassword> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String email, password;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;
  // var userEmail;
  Box<String> feedsBox;

  @override
  void initState() {
    // _setEmail();
    feedsBox = Hive.box<String>("feedsApp");
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // void _setEmail() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var user = localStorage.getString('e');
  //   userEmail = user;
  // }

  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      var data = {
        'email': feedsBox.get('email') == null
            ? 'Email not available'
            : feedsBox.get('email'),
        'password': _passwordController.text,
      };

      try {
        var response = await Provider.of<CallApi>(context, listen: false)
            .postData(data, 'user/update_password');
        var body = jsonDecode(response.body);
        print(body);
        if (body['msg'] == 'Ok') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
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
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    TextFormField(
                      validator: PasswordValidator.validate,
                      controller: _passwordController,
                      obscureText: _obscureText,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //filled: true,

                        labelText: 'New Password*',
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.w300),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                      onSaved: (input) => password = input,
                    ),
                  ]),
                ),
                SizedBox(height: 20),
                TextFormField(
                  autovalidate: true,
                  validator: (value) {
                    if (value.isEmpty) return 'Field cant be empty';
                    if (value != _passwordController.text)
                      return 'Passwords doesn"t match ';
                    return null;
                  },
                  controller: _confirmPasswordController,
                  obscureText: _obscureText,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // filled: true,

                    labelText: 'Re-type Password*',
                    labelStyle: GoogleFonts.montserrat(
                        fontSize: 15, fontWeight: FontWeight.w300),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off)),
                  ),
                  onSaved: (input) => password = input,
                ),
                SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? CircularProgressIndicator(
                        //backgroundColor: Colors.grey,
                        strokeWidth: 1.5,
                      )
                    : RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        textColor: Colors.white,
                        color: Color(0xff01A0C7),
                        disabledColor: Colors.grey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Update Password',
                            style: GoogleFonts.montserrat(fontSize: 15),
                          ),
                        ),
                        onPressed: _isLoading ? null : _submit),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Go Back to Login",
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
