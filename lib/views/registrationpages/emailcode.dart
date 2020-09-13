import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/controllers/auth/auth.dart';
import 'package:nahere/views/registrationpages/retypepassword.dart';

import 'package:provider/provider.dart';

import 'loginpage.dart';

class EmailCodePasswordReset extends StatefulWidget {
  @override
  _EmailCodePasswordResetState createState() => _EmailCodePasswordResetState();
}

class _EmailCodePasswordResetState extends State<EmailCodePasswordReset> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _numberController = TextEditingController();
  //TextEditingController _emailController = TextEditingController();
  String email;

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Box<String> feedsBox;

  @override
  void initState() {
    super.initState();
    feedsBox = Hive.box<String>("feedsApp");
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      var data = {
        'email': feedsBox.get('email') == null
            ? 'Email not available'
            : feedsBox.get('email'),
        'sort_code': _numberController.text,
      };

      try {
        var response = await Provider.of<CallApi>(context, listen: false)
            .postData(data, 'user/validate_password_recovery_code');
        var body = jsonDecode(response.body);
        print(body);
        if (body['msg'] == 'Ok') {
          print(body['msg']);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RetypePassword()),
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
                      validator: EmailCodeRecovery.validate,
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        labelText: 'Recovery code*',
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
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
                        '*input code sent to your email.',
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w100),
                      ),
                    ]),
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
                            'Submit',
                            style: GoogleFonts.montserrat(fontSize: 15),
                          ),
                        ),
                        onPressed: _isLoading ? null : _submit),
                SizedBox(height: 20),
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

// _submit() async {
//     FocusScope.of(context).unfocus();
//     for (Asset asset in multipleimages) {
//       ByteData byteData = await asset.getByteData();
//       List<int> imageData = byteData.buffer.asUint8List();
//       var data = {
//         "user": "117",
//         'message': _whatshappeningController.text,
//         "group": "0",
//         "responding_to": "",
//         "with_picture": "yes ",
//         "pictures": MultipartFile.fromBytes(
//           // 'photo',
//           imageData,
//           filename: 'some-file-name.jpg',
//           contentType: MediaType("image", "jpg"),
//         ) // http.MultipartFile.fromBytes(field, stream, length)     multipleimages.map((e) => e.name).toList(),
//       };
//       try {
//         var response = await Provider.of<CallApi>(context, listen: false)
//             .postData(data, 'social/send_update');
//         var body = jsonDecode(response.body);
//         print(body);

//         if (body['msg'] == "Success!") {
//           print('posted successfully!');
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage2()),
//               (route) => false);
//         } else {
//           _showToast(context, body['msg']);
//         }
//       } catch (e) {
//         print(e);
//         return e.message;
//       }
//     }

// _submit() async {
//     FocusScope.of(context).unfocus();

//     var data = {
//       "user": "117",
//       'message': _whatshappeningController.text,
//       "group": "0",
//       "responding_to": "",
//       "with_picture": "yes ",
//       "pictures":     multipleimages.map((e) => e.name).toList(),
//     };

//     try {
//       var response = await Provider.of<CallApi>(context, listen: false)
//           .postData(data, 'social/send_update');
//       var body = jsonDecode(response.body);
//       print(body);

//       if (body['msg'] == "Success!") {
//         print('posted successfully!');
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => HomePage2()),
//             (route) => false);
//       } else {
//         _showToast(context, body['msg']);
//       }
//     } catch (e) {
//       print(e);
//       return e.message;
//     }
//   }
