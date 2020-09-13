import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/views/pages/homepage2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadFilePage extends StatefulWidget {
  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  bool _isLoading = false;
  //List _file = [];
  List _file1 = [];
  var _file2 = [];
  //var _file3 = ['assets/images/pdf2.jpg'];
  var _scaffoldKey;
  var userData;
  Box<String> feedsBox;
  TextEditingController _whatshappeningFileController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //uploadFile();
    _getUserInfo();
    feedsBox = Hive.box('feedsApp');
  }

  @override
  void dispose() {
    _whatshappeningFileController.dispose();
    super.dispose();
  }

  List<String> docPaths;

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('data');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }

  Future getfile() async {
    List<File> file = await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: [
        'xls',
        'xlsx',
        'pdf',
        'doc',
      ], //'xls', 'xlsx', 'pdf', 'doc'
    );
    setState(() {
      _file1 = file;
    });
  }

  getImageFileFromAsset(String path) async {
    final file = File(path);

    return file;
  }

  // Widget buildGridView() {
  //   // if (_file1 != null)
  //   for (int i = 0; i < _file1.length; i++)
  //     return GridView.count(crossAxisCount: 2, children: [
  //       _file1 != null
  //           ? ClipRRect(child: Image.asset('assets/images/pdf2.jpg'))
  //           : Container()
  //     ]
  //         // List.generate(_file1.length, (index) {
  //         //   // Asset asset = images[index];
  //         //   // print(asset.getByteData(quality: 100));
  //         //   return Padding(
  //         //     padding: EdgeInsets.all(8.0),
  //         //     child: ClipRRect(
  //         //         borderRadius: BorderRadius.all(Radius.circular(15)),
  //         //         child: File.fromUri(_file1)
  //         //   );
  //         // }),
  //         );
  //   //  else
  //   return Container();
  // }

  uploadFile() async {
    //if (_file1 == null) return;
    FocusScope.of(context).unfocus();
    for (int i = 0; i < _file1.length; i++) {
      //  var path2 =
      //    await FlutterAbsolutePath.getAbsolutePath(_file2[i].identifier);
      //  var path2 = FlutterAbsolutePath.getAbsolutePath(_file[i]);
      // print(path2);
      //var file = await getImageFileFromAsset(path2);
      // String fileName = file.path.split(".").last;

      // print(fileName);
      var base64file = base64Encode(_file1[i].readAsBytesSync());
      // print('data:image/$fileName;base64,' + base64Image);
      print(base64file);

      _file2.add(base64file); //'data:application/pdf;base64,' +
      // setState(() {
      //   isLoading = true;
      // });

      // String base64file = base64Encode(_file.readAsBytesSync());

      //final convertbase64file = base64file;
      // feedsBox.put('base64fileconvert', convertbase64file);
      //  print(base64file);
      // String fileName = _file.path.split(".").last;

      // String fileName = path.basename(filePath.path);
      // print('file base name: $fileName');

      setState(() {
        _isLoading = true;
      });
    }
    // _isLoading = false;
    var data = {
      "user": ' ${feedsBox.get('userID')}',
      'message': _whatshappeningFileController.text,
      "group": "0",
      "with_file": "yes",
      "files": _file2 //'data:application/pdf;base64,' + base64file,
    };

    try {
      var response = await Provider.of<CallApi>(context, listen: false)
          .postData(data, 'social/send_update2'); //'social/send_update2'
      var body = jsonDecode(response.body);

      print(body);

      if (response.statusCode == 200) {
        //body['msg'] == "Success!"
        // print('posted successfully!');
        // _showToast(context, 'Posted successfully');
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
          'Add Post to public feeds',
          style: GoogleFonts.montserrat(
            color: Color(0xff01A0C7),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(Icons.camera_alt, color: Color(0xff01A0C7)),
          //     onPressed: loadAssets),
          IconButton(
              icon: Icon(Icons.attach_file, color: Color(0xff01A0C7)),
              onPressed: getfile //_getDocuments //getfile
              ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: SingleChildScrollView(
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
                controller: _whatshappeningFileController,
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
              //for (int i = 0; i <= _file1.length; i++)
              // for (int i = 0; i < _file1.length; i++)
              Center(
                child: GridView.extent(
                    shrinkWrap: true,
                    maxCrossAxisExtent: 150,
                    padding: const EdgeInsets.all(4),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: List.generate(
                      _file1.length,
                      (index) => Container(
                        child: Image.asset('assets/images/file1.png'),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Send',
          backgroundColor: Color(0xff01A0C7),
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xff01A0C7),

                    //valueColor:Color(0xff01A0C7) ,
                    strokeWidth: 1.5,
                  ),
                )
              : Center(
                  child: Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          onPressed: uploadFile //isLoading ? null : _submit
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
