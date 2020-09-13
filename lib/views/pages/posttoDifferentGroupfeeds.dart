import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/views/pages/differentGroupPages.dart';
import 'package:nahere/views/pages/differentgroupuploadfilepage.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class DifferentGroupPagesPost extends StatefulWidget {
//   @override
//   _DifferentGroupPagesPostState createState() => _DifferentGroupPagesPostState();
// }

// class _DifferentGroupPagesPostState extends State<DifferentGroupPagesPost> {

//   var userData;
//   Box<String> feedsBox;
//   TextEditingController _whatshappeningController = TextEditingController();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   void _getUserInfo() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var userJson = localStorage.getString('data');
//     var user = json.decode(userJson);
//     setState(() {
//       userData = user;
//     });
//   }
//   @override
//   void initState() {
//    _getUserInfo();
//     super.initState();
//     feedsBox = Hive.box('feedsApp');
//   }

//  //Future<http.Response>
//   _submit() async {

//       FocusScope.of(context).unfocus();
//       // setState(() {
//       //   _isLoading = true;
//       // });
//       // Timer(Duration(seconds: 6), onTimeout);
//       var data = {
//         "user": "117",
//         'message': _whatshappeningController.text,
//         "group": '${feedsBox.get('GROUPIDEACH')}',//'0'
//         "responding_to": "",
//       };
//      // final url = 'https://empl-dev.site/api/social/send_update';
//        //Map<String, String> headers = {
//       //'Content-type': 'application/json',
//       //'Accept': 'application/json',
//     //};
//       try {
//         var response = //http.post(url );
//          await Provider.of<CallApi>(context, listen: false)
//             .postData(data, 'social/send_update');
//         var body = json.decode(response.body);
//         print(body);
//         if (body['msg'] == "Success!") {
//           print('posted successfully!');
//            Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => DifferentGroupPages()),
//               (route) => false);

//         } else {
//           _showToast(context, body['msg']);
//         }

//         // setState(() {
//         //   _isLoading = false;
//         // });
//       } catch (e) {
//          print(e);
//         return e.message;

//         //  setState(() {
//         //   _isLoading = false;
//         // });

//         // return _showToast(
//         //     context, 'Please check your internet connection and try again!!!');
//       }

//   }
//   @override
//   Widget build(BuildContext context) {
//    // final themeProvider = Provider.of<ThemeProvider>(context);
//     return Scaffold(
//       //tobe removed for darkmode
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(Icons.clear, color: Color(0xff01A0C7)),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         elevation: 0.0,
//         centerTitle: true,
//         title: Text(
//          'Post to: ${feedsBox.get('GROUPNAME')}',
//           style: GoogleFonts.montserrat(
//             color: Color(0xff01A0C7),
//             fontSize: 15,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//          //toberemoved for darkmode
//         backgroundColor: Colors.white,
//         actions:<Widget> [
//           IconButton(
//             icon: Icon(Icons.camera_alt, color: Color(0xff01A0C7)),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//           IconButton(
//             icon: Icon(Icons.attach_file, color: Color(0xff01A0C7)),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20, top: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               CircleAvatar(
//                      backgroundColor: Colors.white,
//                         radius: 20,
//                     backgroundImage: NetworkImage(userData != null
//                 ? userData['photo_path']
//                 : '',
//                 scale: 1.0
//                             )
//                   ) ,
//               TextField(
//                 style: GoogleFonts.montserrat(
//                           color:  Colors.black,//themeProvider.isLightTheme ? Colors.white:   Colors.black,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                         ),
//                 controller: _whatshappeningController,
//                       decoration: InputDecoration(
//                         hintText: "Whats Happening ?",
//                         hintStyle: GoogleFonts.montserrat(
//                          // color: Colors.white,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                       scrollPadding: EdgeInsets.all(20.0),
//                       keyboardType: TextInputType.multiline,
//                       maxLines: 99999,
//                       autofocus: true,
//                     ) ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         tooltip: 'Send',
//           backgroundColor: Color(0xff01A0C7),
//           child: Center(child: Icon(Icons.send, color: Colors.white, )),
//           onPressed:
//             _submit
//           ),
//       resizeToAvoidBottomPadding: true,
//     );
//   }
//    _showToast(BuildContext context, msg) {
//     final snackBar = SnackBar(
//       behavior: SnackBarBehavior.floating,
//       backgroundColor:Color(0xff01A0C7) ,
//       shape: RoundedRectangleBorder(),
//       content: Text(msg,style:   GoogleFonts.montserrat(fontSize: 12),),
//       duration: Duration(seconds: 5),
//     );
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }
// }

class DifferentGroupPagesPost extends StatefulWidget {
  @override
  _DifferentGroupPagesPostState createState() =>
      _DifferentGroupPagesPostState();
}

class _DifferentGroupPagesPostState extends State<DifferentGroupPagesPost> {
  var userData;
  Box<String> feedsBox;
  bool _isLoading = false;
  TextEditingController _typeaMessageController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  // void _getUserInfo() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var userJson = localStorage.getString('data');
  //   var user = json.decode(userJson);
  //   setState(() {
  //     userData = user;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _getUserInfo();

    feedsBox = Hive.box('feedsApp');
  }

  @override
  void dispose() {
    _typeaMessageController.dispose();

    super.dispose();
  }

  _submit1() async {
    FocusScope.of(context).unfocus();
    _isLoading = true;
    if (_typeaMessageController.text.isEmpty) {
      return null;
    }
    setState(() {
      _isLoading = true;
    });
    var data = {
      "user": ' ${feedsBox.get('userID')}',
      'message': _typeaMessageController.text,
      "group": '${feedsBox.get('GROUPIDEACH')}', //"0",
      "with_file": "no",
    };

    try {
      var response = //http.post(url );
          await Provider.of<CallApi>(context, listen: false)
              .postData(data, 'social/send_update');
      var body = json.decode(response.body);
      print(body);

      if (body['msg'] == "Success!") {
        print('posted successfully!');

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DifferentGroupPages()),
            (route) => false);
      } else {
        _showToast(context, body['msg']);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
      return _showToast(context, 'Post not sent!! Please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // IconButton(icon: Icon(Icons.attach_file,color: Color(0xff01A0C7)), onPressed: (){}),
              //IconButton(icon: Icon(Icons.camera_alt,color: Color(0xff01A0C7)), onPressed: (){}),
              Expanded(
                child: Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  elevation: 2,
                  child: Row(children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: size.width,
                          maxWidth: size.width,
                          minHeight: 25.0,
                          maxHeight: 300.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            autofocus: false,
                            style: GoogleFonts.montserrat(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            cursorColor: Color(0xff01A0C7),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _typeaMessageController,
                            // _handleSubmitted : null,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.attach_file,
                                    color: Colors.grey, // Color(0xff01A0C7)
                                  ),
                                  onPressed: () {
                                    // _showBottomSheet();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DifferentUploadFilePage()),
                                    );
                                  }),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey, // Color(0xff01A0C7)
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsPage1()));
                                  }),
                              // prefixIcon: IconButton(
                              //     icon: Icon(Icons.attach_file),
                              //     color:Colors.grey,// Color(0xff01A0C7),
                              //     onPressed: () {}),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  top: 13.0,
                                  left: 13.0,
                                  right: 13.0,
                                  bottom: 13.0),
                              hintText: "Type a Message",
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xff01A0C7),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          // backgroundColor: Color(0xff01A0C7),

                          //valueColor:Color(0xff01A0C7) ,
                          strokeWidth: 1.5,
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: _submit1),
                ),
              ),
            ],
          ),
        ));
  }

  _showToast(BuildContext context, msg) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xff01A0C7),
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

class DetailsPage1 extends StatefulWidget {
  @override
  _DetailsPage1State createState() => _DetailsPage1State();
}

class _DetailsPage1State extends State<DetailsPage1> {
  var userData;

  TextEditingController _whatshappeningController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Box<String> feedsBox;
  List<Asset> resultList;

  List filess = [];
  bool isLoading = false;

  List<Asset> images = List<Asset>();

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('data');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    feedsBox = Hive.box('feedsApp');
  }

  @override
  void dispose() {
    _whatshappeningController.dispose();

    super.dispose();
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          print(asset.getByteData(quality: 100));
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            ),
          );
        }),
      );
    else
      return Container();
  }

  Future<void> loadAssets() async {
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        //  cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      error = error;
    });
  }

  getImageFileFromAsset(String path) async {
    final file = File(path);

    return file;
  }

  _submit() async {
    FocusScope.of(context).unfocus();
    isLoading = false;
    if (_whatshappeningController.text.isEmpty) {
      return null;
    }

    for (int i = 0; i < images.length; i++) {
      var path2 =
          await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);

      var file = await getImageFileFromAsset(path2);
      String fileName = file.path.split(".").last;

      var base64Image = base64Encode(file.readAsBytesSync());

      filess.add('data:image/$fileName;base64,' + base64Image);
      setState(() {
        isLoading = true;
      });
    }
    var data = {
      "user": ' ${feedsBox.get('userID')}',
      'message': _whatshappeningController.text,
      "group": '${feedsBox.get('GROUPIDEACH')}',
      "with_file": "yes",
      "files": filess,
    };

    try {
      var response = await Provider.of<CallApi>(context, listen: false)
          .postData(data, 'social/send_update'); //'social/send_update2'
      var body = jsonDecode(response.body);

      // print(body);

      if (body['msg'] == "Success!") {
        // print('posted successfully!');
        _showToast(context, 'Posted successfully');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DifferentGroupPages()),
            (route) => false);
      } else {
        _showToast(context, body['msg']);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      //return e.message;
      return _showToast(context, 'Post not sent!! Please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.clear, color: Color(0xff01A0C7)),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Add post to ${feedsBox.get('GROUPNAME')}',
          style: GoogleFonts.montserrat(
            color: Color(0xff01A0C7),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.camera_alt, color: Color(0xff01A0C7)),
              onPressed: loadAssets),
          // IconButton(
          //     icon: Icon(Icons.attach_file, color: Color(0xff01A0C7)),
          //     onPressed: () {
          //       loadAssets();
          //     }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: NetworkImage(
                  userData != null ? userData['photo_path'] : '',
                  scale: 1.0),
            ),
            TextField(
              style: GoogleFonts.montserrat(
                // color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              controller: _whatshappeningController,
              decoration: InputDecoration(
                hintText: "Whats Happening ?",
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              scrollPadding: EdgeInsets.all(20.0),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              // autofocus: true,
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Send',
          backgroundColor: Color(0xff01A0C7),
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Color(0xff01A0C7),

                  //valueColor:Color(0xff01A0C7) ,
                  strokeWidth: 1.5,
                )
              : Center(
                  child: Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          onPressed: isLoading ? null : _submit),
      resizeToAvoidBottomPadding: true,
    );
  }

  _showToast(BuildContext context, msg) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xff01A0C7),
      shape: RoundedRectangleBorder(),
      content: Text(
        msg,
        style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white),
      ),
      duration: Duration(seconds: 5),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
