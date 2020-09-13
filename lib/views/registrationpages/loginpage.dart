// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:nahere/controllers/auth/forgot_page.dart';
// import 'package:nahere/main.dart';
// import 'package:nahere/views/pages/register_page.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:nahere/bloc.navigation_bloc/navigation_bloc.dart';

// // import 'homepage.dart';

// class LoginPage extends StatelessWidget with NavigationStates {
//   // This widget is the root of your application.

//   final routes = <String, WidgetBuilder>{
//     RegisterPage.tag: (context)=>RegisterPage(),
//     ForgotPage.tag: (context)=>ForgotPage()
//   };

//   static String tag = 'main';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'NaHere',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'NaHere'),
//       routes: routes,
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 18.0);
//   final formKey = new GlobalKey<FormState>();

//   String email = "";
//   String password = "";
//   String msg = "";

//   bool _isLoading = false;

//   signIn(String email, pass) async {

//     setState(() { msg = ""; }); //clear error message after button is clicked

//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     Map data = { 'email': email, 'password': pass };
//     var jsonResponse = null;
//     var response = await http.post(
//       "https://empl-dev.site/api/user/login",
//       body: data
//     );

//     if(response.statusCode == 200) {

//       jsonResponse = json.decode(response.body);
//       if(jsonResponse['status'].toString() == "400"){
//         setState(() {
//           msg = jsonResponse['msg'].toString();
//         });

//       }else{
//         sharedPreferences.setString("token", jsonResponse['token']);
//         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MyApp()), (Route<dynamic> route) => false);
//       }

//       setState(() {
//         _isLoading = false;
//       });

//     }
//     else {

//       setState(() {
//         _isLoading = false;
//       });

//       setState(() {
//         msg = "Connection Error.";
//       });

//     }

//   }

//   final TextEditingController emailController = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();
//   final loader = CircularProgressIndicator();

//   @override
//   Widget build(BuildContext context) {

//     final emailField = TextFormField(
//       controller: emailController,
//       keyboardType: TextInputType.emailAddress,
//       obscureText: false,
//       style: style,
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Email",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
//       ),
//       validator: (val) {
//         if(val.isEmpty){
//           return "Enter Email";
//         }
//         return null;
//       },
//       onSaved: (String val) => setState(() => email = val),
//     );

//     final passwordField = TextFormField(
//       controller: passwordController,
//       obscureText: true,
//       style: style,
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Password",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
//       ),
//       validator: (val) {
//         if(val.isEmpty){
//           return "Enter Password";
//         }
//         return null;
//       },
//       onSaved: (String val) => setState(() => password = val),
//     );

//     final loginButon = Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(30.0),
//       color: Color(0xff01A0C7),
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         onPressed: () {
//           if (formKey.currentState.validate()) {
//             setState(() {
//               _isLoading = true;
//             });
//             signIn(emailController.text, passwordController.text);
//             // If the form is valid, display a Snackbar.
//             // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
//           }
//         },
//         child: Text("Login",
//             textAlign: TextAlign.center,
//             style: style.copyWith(
//                 color: Colors.white, fontWeight: FontWeight.bold)),
//       ),
//     );

//     final forgotLabel = FlatButton(
//       child: Text('Forgot Password?' ,
//       style: TextStyle(color: Colors.black54),),
//       onPressed: () {
//         Navigator.of(context).pushNamed(ForgotPage.tag);
//       },
//     );

//     final FlatButton registerLabel = FlatButton(
//       child: Text('Register' ,
//       style: TextStyle(color: Colors.black54),),
//       onPressed: () {
//          // Navigator.of(context).pushNamed(RegisterPage.tag);
//       },
//     );

//     return new Scaffold(

//       body: Form(
//         key: formKey,
//         child: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(36.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 60.0,
//                       child: Image.asset(
//                         "assets/appiconicon.png",
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     SizedBox(height: 45.0),
//                     emailField,
//                     SizedBox(height: 25.0),
//                     passwordField,
//                     SizedBox(
//                       height: 35.0,
//                     ),
//                     SizedBox(
//                       child: _isLoading ? Center(child: CircularProgressIndicator()) : Column(
//                         children: <Widget>[
//                           loginButon,
//                         ],
//                       )
//                     ),

//                     SizedBox(
//                       height: 15.0,
//                     ),
//                     Text(msg, style: TextStyle(fontSize: 18.0, color: Colors.red, fontFamily: 'Montserrat'),),
//                     forgotLabel,
//                     registerLabel,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//{"status":200,"msg":"Success!","data":{"user_id":"640","firstname":"Kuti","lastname":"Gbolahan","profile_photo":"","token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Imt1dGlnYm9sYWhhbi5hYkBnbWFpbC5jb20iLCJ1c2VyX2lkIjoiNjQwIiwiZmlyc3RuYW1lIjoiS3V0aSJ9.k-26WSUcePV7zuO484vIpx1y7M7ycpOO2hQyWXpuEJQ"}}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/controllers/auth/auth.dart';

import 'package:nahere/views/pages/homepage2.dart';
import 'package:nahere/views/pages/homepage3.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String email = "";
  String password = "";

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  bool _isLoading = false;
  Box<String> feedsBox;

  @override
  void initState() {
    super.initState();

    feedsBox = Hive.box('feedsApp');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future _login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      FocusScope.of(context).unfocus();
      setState(() {
        _isLoading = true;
      });

      var data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      try {
        var response = await Provider.of<CallApi>(context, listen: false)
            .postData(data, 'user/login');

        var body = jsonDecode(response.body);
        print(body);
        //  _showToast(context, body['msg']);

        if (body['msg'] == "Success!") {
          print('login successful');

          final val = _emailController.text;
          var val2 = body['data']['user_id'];
          var firstname = body['data']['firstname'];
          var lastname = body['data']['lastname'];
          feedsBox.put('userID', val2);
          feedsBox.put('firstname', firstname);
          feedsBox.put('lastname', lastname);
          //profile screen email
          feedsBox.put('email2', val);
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          // localStorage.setString('token', body['token']);
          localStorage.setString('data', json.encode(body['data']));
          final page = HomePage3();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => page), (route) => false);
        } else {
          _showToast(context, body['msg']);
        }

        setState(() {
          _isLoading = false;
        });

        print(body);
      } catch (e) {
        print('catch error');

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
            padding: EdgeInsets.all(26),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                  child: Image.asset(
                    "assets/appiconicon.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          style: GoogleFonts.montserrat(
                              fontSize: 17, fontWeight: FontWeight.w300),
                          validator: EmailValidator.validate,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),

                            // filled: true,

                            labelText: 'Email',
                            labelStyle: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                          onSaved: (input) => email = input,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.w300),
                            validator: PasswordValidator.validate,
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // filled: true,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.montserrat(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                            onSaved: (input) => password = input),
                        SizedBox(
                          height: 20,
                        ),
                        _isLoading
                            ? CircularProgressIndicator(
                                backgroundColor: Color(0xff01A0C7),

                                //valueColor:Color(0xff01A0C7) ,
                                strokeWidth: 1.5,
                              )
                            : Container(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  textColor: Colors.white,
                                  disabledColor: Colors.grey,
                                  color: Color(0xff01A0C7),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    child: Text('Login',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 17)),
                                  ),
                                  onPressed: _isLoading ? null : _login,
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                                },
                                child: Text("Forgot Password?",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12) //TextStyle(fontSize: 10),
                                    ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ]),
                        SizedBox(height: 80),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            "Don't have an account? REGISTER",
                            style: GoogleFonts.montserrat(fontSize: 12),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        )
                      ],
                    )),
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
        style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white),
      ),
      duration: Duration(seconds: 4),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
//await http.post('https://empl-dev.site/api/user/login', body: data);
