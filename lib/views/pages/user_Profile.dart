import 'dart:convert';
import 'dart:io';

//import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:image_picker/image_picker.dart';

import 'package:nahere/views/pages/edit_Profilepage.dart';

import 'package:nahere/widgets/drawer.dart';

import 'package:http/http.dart' as http;
import 'package:nahere/models/user_profile.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserProfileSee extends StatefulWidget {
  @override
  _UserProfileSeeState createState() => _UserProfileSeeState();
}

class _UserProfileSeeState extends State<UserProfileSee> {
  File imageFile;
  var userData;
  Box<String> feedsBox;
  Future userProfileload;
  var imageuser;

  @override
  void initState() {
    _getUserInfo();
    // _getuserImage();
    // getUserProfile();
    feedsBox = Hive.box('feedsApp');
    getUserProfile();

    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('data');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }

  // void _getuserImage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var userimage = prefs.getString('imagekey');
  //   var user = json.decode(userimage);
  //   setState(() {
  //     imageuser = user;
  //   });
  // }

  Future getFile() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image;
    });
  }

  Future<UserProfiless> getUserProfile() async {
    try {
      final url =
          'https://empl-dev.site/api/user/get_profile?user_id=${userData['user_id']}';
      var res = await http.get(url);
      if (res.statusCode == 200) {
        print('${userData['user_id']}');
        return UserProfiless.fromJson(json.decode(res.body));
      } else {
        throw Exception('Failed to load feeds');
      }
      //await Provider.of<CallApi>(context)
      //  .getData('user/get_profile?user_id=640');

      // UserProfile userProfile = standardSerializers.deserializeWith(
      //   UserProfile.serializer, jsonDecode(res.body));
      //print(userProfile);
      //return userProfile;
    } catch (e) {
      print(e);
      return e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        //tobe removed for darkmode
        // backgroundColor: Colors.white,
        // key: _scaffoldKey,
        appBar: AppBar(
          // iconTheme: new IconThemeData(color: Color(0xff01A0C7)),
          elevation: 0.0,
          //tobe removed for darkmode
          // backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'User Profile',
            style: GoogleFonts.montserrat(
                color: Color(0xff01A0C7),
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
        ),
        drawer: MyDrawer(),
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: FutureBuilder<UserProfiless>(
                future: getUserProfile(),
                builder: (BuildContext context,
                    AsyncSnapshot<UserProfiless> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SpinKitFadingCircle(
                            color: Color(0xff01A0C7),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('User Profile Not Avilable')
                          ]),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/interface.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Oops,something went wrong',
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            // style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            'Please check your internet connection !!!',
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            // style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            textColor: Colors.white,
                            color: Color(0xff01A0C7),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserProfileSee()),
                                  (route) => false);
                            },
                            child: Text(
                              'Try Again',
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(
                                      color: Color(0xff01A0C7), width: 3),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      feedsBox.get('base64Imageconvert') != null
                                          ? MemoryImage(
                                              base64Decode(
                                                feedsBox
                                                    .get('base64Imageconvert'),
                                              ),
                                            )
                                          : NetworkImage(
                                              userData != null
                                                  ? userData['photo_path']
                                                  : '',
                                              scale: 1.0),
                                ),
                              ),
                              // : Container(
                              //     width: 100,
                              //     height: 100,
                              //     decoration: BoxDecoration(
                              //       borderRadius:
                              //           BorderRadius.circular(200),
                              //       border: Border.all(
                              //           color: Color(0xff01A0C7), width: 3),
                              //     ),
                              //     child: CircleAvatar(
                              //       backgroundColor: Colors.white,
                              //       backgroundImage: NetworkImage(
                              //           userData != null
                              //               ? userData['photo_path']
                              //               : '',
                              //           scale: 1.0),
                              //     ),
                              //   ),
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Color(0xff01A0C7),
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    final firstnameEdit =
                                        snapshot.data.data.firstname;
                                    final lastnameEdit =
                                        snapshot.data.data.lastname;
                                    final othernameEdit =
                                        snapshot.data.data.othernames;
                                    final phonenumberEdit =
                                        snapshot.data.data.phone;
                                    final genderEdit =
                                        snapshot.data.data.gender;
                                    final dobEdit = snapshot.data.data.dob;
                                    feedsBox.put(
                                        'firstNameEdit', firstnameEdit);
                                    feedsBox.put('lastNameEdit', lastnameEdit);
                                    feedsBox.put(
                                        'otherNameEdit', othernameEdit);
                                    feedsBox.put(
                                        'phoneNumberEdit', phonenumberEdit);
                                    feedsBox.put('genderEdit', genderEdit);
                                    feedsBox.put('dobEdit', dobEdit);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfilePage()),
                                    );
                                  })
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Firstname",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: snapshot.data.data.firstname),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Lastname",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: snapshot.data.data.lastname),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Othername",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: snapshot.data.data.othernames),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Email",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: snapshot.data.data.email),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Phone",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: snapshot.data.data.phone),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Gender",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: snapshot.data.data.gender != null
                                    ? snapshot.data.data.gender
                                    : feedsBox.get('genderSelect')),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Date of Birth",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextField(
                            enabled: false,
                            controller: TextEditingController(
                                text: snapshot.data.data.dob),
                          )
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        )

        // SafeArea(
        //   child: FutureBuilder<UserProfiless>(
        //     future: getUserProfile(),
        //     builder:
        //         (BuildContext context, AsyncSnapshot<UserProfiless> snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: <Widget>[
        //               SpinKitFadingCircle(
        //                 color: Color(0xff01A0C7),
        //               ),
        //             ],
        //           ),
        //         );
        //       } else if (snapshot.connectionState == ConnectionState.none) {
        //         return Center(
        //           child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: <Widget>[Text('User Profile Not Avilable')]),
        //         );
        //       } else if (snapshot.hasError) {
        //         return Center(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: <Widget>[
        //               Image.asset(
        //                 'assets/images/interface.png',
        //                 width: 70,
        //                 height: 70,
        //                 fit: BoxFit.fill,
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               Text(
        //                 'Oops,something went wrong',
        //                 style: GoogleFonts.montserrat(
        //                     fontSize: 12, fontWeight: FontWeight.w500),
        //                 // style: TextStyle(color: Colors.red),
        //               ),
        //               Text(
        //                 'Please check your internet connection !!!',
        //                 style: GoogleFonts.montserrat(
        //                     fontSize: 12, fontWeight: FontWeight.w500),
        //                 // style: TextStyle(color: Colors.red),
        //               ),
        //               SizedBox(
        //                 height: 10,
        //               ),
        //               RaisedButton(
        //                 textColor: Colors.white,
        //                 color: Color(0xff01A0C7),
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(7)),
        //                 onPressed: () {
        //                   Navigator.pushAndRemoveUntil(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) => UserProfileSee()),
        //                       (route) => false);
        //                 },
        //                 child: Text(
        //                   'Try Again',
        //                   style: GoogleFonts.montserrat(
        //                     fontSize: 10,
        //                     fontWeight: FontWeight.w500,
        //                   ),
        //                 ),
        //               )
        //             ],
        //           ),
        //         );
        //       } else if (snapshot.connectionState == ConnectionState.done) {
        //         return Column(children: [
        //           Container(
        //             width: 100,
        //             height: 100,
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(200),
        //               border: Border.all(color: Color(0xff01A0C7), width: 3),
        //               boxShadow: [
        //                 BoxShadow(
        //                     color: Colors.white,
        //                     blurRadius: 6,
        //                     spreadRadius: 6,
        //                     offset: Offset.fromDirection(0, 0))
        //               ],
        //             ),
        //             child: CircleAvatar(
        //               backgroundColor: Colors.white,
        //               backgroundImage:  NetworkImage(userData != null
        //                         ? userData['photo_path']
        //                         : '',
        //                         scale: 1.0
        //                     ),
        //             ),
        //           ),
        //           SizedBox(
        //             height: 7,
        //           ),
        //           Flexible(
        //             child: Padding(
        //               padding: const EdgeInsets.all(7.0),
        //               child: Card(
        //                 elevation: 7,
        //                 child: Center(
        //                   child: Column(
        //                     children: [
        //                        SizedBox(
        //                         height: 15,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         // crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [

        //                           Text(
        //                             'Firstname:',
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w500,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                           Text(
        //                             snapshot.data.data.firstname,
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w300,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       SizedBox(
        //                         height: 10,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         // crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             'Lastname:',
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w500,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                           Text(
        //                             snapshot.data.data.lastname,
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w300,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                        SizedBox(
        //                         height: 10,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         // crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             'Othername:',
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w500,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                           Text(
        //                             snapshot.data.data.othernames,
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w300,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                        SizedBox(
        //                         height: 10,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         // crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             'Email:',
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w500,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                           Text(
        //                             snapshot.data.data.email,
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w300,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                        SizedBox(
        //                         height: 10,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         // crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             'Phone:',
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w500,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                           Text(
        //                             snapshot.data.data.phone,
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w300,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                        SizedBox(
        //                         height: 10,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         // crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             'Gender:',
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w500,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                           Text(
        //                             snapshot.data.data.gender,
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w300,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                        SizedBox(
        //                         height: 10,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         // crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             'Dob:',
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w500,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                           Text(
        //                             snapshot.data.data.dob,
        //                             style: GoogleFonts.montserrat(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w300,
        //                               // color: Colors.white,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       SizedBox(
        //                         height: 200,
        //                       ),
        //                      RaisedButton(
        //                          shape: RoundedRectangleBorder(
        //                               borderRadius: BorderRadius.circular(8)
        //                             ),
        //                           textColor: Colors.white,
        //                           disabledColor: Colors.grey,
        //                           color: Color(0xff01A0C7),
        //                           child: Padding(
        //                             padding:
        //                                 EdgeInsets.symmetric(horizontal: 50),
        //                             child: Text(
        //                               'Edit Profile', style: GoogleFonts.montserrat(
        //                                     fontSize: 17)
        //                             ),
        //                           ),
        //                           onPressed:(){
        //                               Navigator.pushAndRemoveUntil(
        //                 context,
        //                 MaterialPageRoute(builder: (context) => EditProfilePage()),
        //                 (route) => false);
        //                           }),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ]);
        //       }
        //       return Container();
        //     },
        //   ),
        // ),
        );
  }
}
// Future<SocialFeeds1> publicFeeds() async {
//     String fileName = "offlinefeeds.json";
//     var dir = await getTemporaryDirectory();
//     File file = File(dir.path + "/" + fileName);

//     if (file.existsSync()) {
//       print('Loading from cache');
//       var jsonData = file.readAsStringSync();
//       SocialFeeds1 socialFeeds1 = SocialFeeds1.fromJson(json.decode(jsonData));
//       return socialFeeds1;
//     } else {
//       print("Loading from API");
//       final response = await http.get(
//           //'https://empl-dev.site/api/social/fetch_updates?user=${userData['user_id']}&group_id=0&page=0&limit=25');
//           'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=0&page=0&limit=1000');
//       //'https://empl-dev.site/api/social/fetch_updates?user=45&group_id=snapshot.data.data[index].group_id&page=0&limit=25');

//       if (response.statusCode == 200) {
//         // print('${userData['user_id']}');
//         // print( SocialFeeds1.fromJson(json.decode(response.body)));
//         var res = SocialFeeds1.fromJson(json.decode(response.body));
//         file.writeAsStringSync(response.body,
//             flush: true, mode: FileMode.write);
//         return res;
//       } else {
//         throw Exception('Failed to load feeds');
//       }
//     }
//   }

//   Future<SocialFeeds1> pub() async {
//     String fileName = "offlinefeedspub.json";
//     var dir = await getTemporaryDirectory();
//     File file = File(dir.path + "/" + fileName);
//     final response = await http.get(
//         'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=0&page=0&limit=1000');
//     if (response.statusCode == 200) {
//       // print('${userData['user_id']}');
//       // print( SocialFeeds1.fromJson(json.decode(response.body)));
//       var res = SocialFeeds1.fromJson(json.decode(response.body));
//       file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
//       print('Loading from api');
//       return res;
//     } else if (file.existsSync()) {
//       print('Loading from cache');
//       var jsonData = file.readAsStringSync();
//       SocialFeeds1 socialFeeds1 = SocialFeeds1.fromJson(json.decode(jsonData));
//       return socialFeeds1;
//     } else {
//       throw Exception('Failed to load feeds');
//     }
//   }

// void uploadFile(filePath) async {
//   if (imageFile == null) return;
//   String base64Image = base64Encode(imageFile.readAsBytesSync());
//   print(base64Image);
//   String fileName = imageFile.path.split("/").last;
//   // String fileName = path.basename(filePath.path);
//   print('file base name: $fileName');
//   setState(() {
//     _isLoading = true;
//   });

//   try {
//     FormData formData = FormData.fromMap({
//       'user_id': userData['user_id'],
//       'file': base64Image //await MultipartFile.fromFile(base64Image, ),
//     });
//     Response response = await Dio().post(
//         // 'https://empl-dev.site/api/company/upload_images2?to_where=user_photo',
//         'https://empl-dev.site/api/company/upload_images2?to_where=user_photo',
//         data: formData);

//     print('File upload response: $response');
//     // return( '$response');
//     _showToast(context, response.data['msg']);

//     setState(() {
//       _isLoading = false;
//     });
//   } catch (e) {
//     print('exception caught: $e');
//     setState(() {
//       _isLoading = false;
//     });
//     return _showToast(context, 'Image not uploaded successfully');
//   }
// }
