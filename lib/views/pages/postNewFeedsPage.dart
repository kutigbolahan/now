import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_absolute_path/flutter_absolute_path.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/controllers/auth/auth.dart';
import 'package:nahere/views/pages/homepage2.dart';
import 'package:nahere/views/pages/uploadfilepage.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DetailsPage extends StatefulWidget {
  final Widget gridviewbuilt;
  DetailsPage({Key key, this.gridviewbuilt}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var userData;

  TextEditingController _whatshappeningController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('ws://api.empl-dev.site:443'));

  Box<String> feedsBox;
  List<Asset> resultList;

  List filess = [];
  //File _file;

  List<Asset> images = List<Asset>();
  bool isLoading = false;
  //bool _isLoading = false;

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
    // _submit();
  }

  @override
  void dispose() {
    _whatshappeningController.dispose();
    channel.sink.close();
    super.dispose();
  }

  Widget buildGridView() {
    if (images != null)
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          //print(asset.getByteData(quality: 100));
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
      resultList = MultiImagePicker.pickImages != null
          ? await MultiImagePicker.pickImages(
              maxImages: 4,
              enableCamera: true,
              selectedAssets: images != null ? images : images,
              // cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
            )
          : Text('data');

      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => DetailsPage()),
      //     (route) => false);
    } on Exception catch (e) {
      error = e.toString();
      // print(error);
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      error = error;
      // print(error);
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

      // print(path2);
      var file = await getImageFileFromAsset(path2);
      String fileName = file.path.split(".").last;

      // print(fileName);
      var base64Image = base64Encode(file.readAsBytesSync());
      print(base64Image);
      // print(file);

      filess.add('data:image/$fileName;base64,' +
          base64Image); //'data:image/$fileName;base64,' +
      setState(() {
        isLoading = true;
      });
    }

    var data = {
      "user": ' ${feedsBox.get('userID')}',
      'message': _whatshappeningController.text,
      "group": "0",
      "with_file": "yes",
      "files": filess,
    };

    try {
      var response = await Provider.of<CallApi>(context, listen: false)
          .postData(data, 'social/send_update'); //'social/send_update2'
      var body = jsonDecode(response.body);

      //print(body);

      if (body['msg'] == "Success!") {
        // print('posted successfully!');
        _showToast(context, 'Posted successfully');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage2()),
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
          'Add New Post',
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
          //     onPressed: () {}),
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
              //  feedsBox.get('base64Imageconvert') != null
              //                     ? MemoryImage(
              //                         base64Decode(
              //                           feedsBox.get('base64Imageconvert'),
              //                         ),
              //                       )
              //                     : NetworkImage(
              //                         userData != null
              //                             ? userData['photo_path']
              //                             : '',
              //                         scale: 1.0),
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
          onPressed: _submit //isLoading ? null : _submit
          ),
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
        style: GoogleFonts.montserrat(fontSize: 12),
      ),
      duration: Duration(seconds: 5),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

class PostFeeds extends StatefulWidget {
  // final WebSocketChannel channel;
  // PostFeeds({this.channel});
  @override
  _PostFeedsState createState() => _PostFeedsState();
}

class _PostFeedsState extends State<PostFeeds> {
  var userData;
  Box<String> feedsBox = Hive.box('feedsApp');
  final TextEditingController _typeaMessageController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // List<Asset> multipleimages = List<Asset>();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  //var websocketsURL = 'https://api.empl-dev.site:443';
  // final IOWebSocketChannel channel =
  //     IOWebSocketChannel.connect(Uri.parse('ws://api.empl-dev.site:443'));

  @override
  void dispose() {
    _typeaMessageController.dispose();
    super.dispose();
  }

  void goToMainPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage2()));
  }

  _submit1() async {
    FocusScope.of(context).unfocus();
    _isLoading = false;
    if (_typeaMessageController.text.isEmpty) {
      return null;
    }
    setState(() {
      _isLoading = true;
    });
    var data = {
      "user": ' ${feedsBox.get('userID')}',
      'message': _typeaMessageController.text,
      "group": "0",
      "with_file": "no",
    };

    try {
      var response = await Provider.of<CallApi>(context, listen: false)
          .postData(data, 'social/send_update');
      var body = json.decode(response.body);
      print(body);
      if (body['msg'] == "Success!") {
        print('posted successfully!');

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage2()),
            (route) => false);
      } else {
        _showToast(context, body['msg']);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
      // return e.message;
      return _showToast(context, 'Post not sent!! Please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
        key: _scaffoldKey,
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
                    // Expanded(
                    //     flex: 1,
                    //     child: IconButton(
                    //         icon: Icon(Icons.add), onPressed: () {})),
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
                            onChanged: (value) {
                              final texfieldvalue =
                                  _typeaMessageController.text;
                              feedsBox.put('textfieldValue', texfieldvalue);
                            },
                            //autofocus: true,
                            //validator: EditProfileValidator.validate,
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
                                              UploadFilePage()),
                                    );
                                  }),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey, // Color(0xff01A0C7)
                                  ),
                                  onPressed: () {
                                    // _showBottomSheet();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsPage()),
                                    );
                                  }),
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
                      // border: Border.all(
                      //   color: Colors.red[500],
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Color(0xff01A0C7),

                          //valueColor:Color(0xff01A0C7) ,
                          strokeWidth: 1.5,
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed:
                              // () {
                              //   widget.channel.sink
                              //       .add(_typeaMessageController.text);
                              // }
                              _submit1),
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
        style: GoogleFonts.montserrat(
          fontSize: 12,
        ),
      ),
      duration: Duration(seconds: 5),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
