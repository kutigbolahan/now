import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:nahere/controllers/auth/auth.dart';
import 'package:nahere/models/user_profile.dart';

import 'package:nahere/views/pages/user_Profile.dart';
import 'package:nahere/views/pages/homepage2.dart';
import 'package:nahere/views/pages/settings_page.dart';

import 'package:nahere/views/registrationpages/loginpage.dart';
import 'package:nahere/widgets/apptheme.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Box<String> feedsBox;
  var userData;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    feedsBox = Hive.box('feedsApp');
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('data');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
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
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    //themeNotifier
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Drawer(
            child: SingleChildScrollView(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Color(0xff01A0C7),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                UserAccountsDrawerHeader(
                  accountName: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          feedsBox.get('firstname') != null
                              ? '${feedsBox.get('firstname')}'
                              : '${userData['firstname']}',
                          //todo
                          // userData != null
                          //     ? '${userData['firstname']}' //'${userData['lastname']}'
                          //     : '', //${userData['user_id']}
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: themeNotifier.lightTheme
                                ? Colors.white
                                : Color(0xff01A0C7),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          feedsBox.get('lastname') != null
                              ? '${feedsBox.get('lastname')}'
                              : '${userData['lastname']}',
                          //todo
                          // userData != null
                          //     ? '${userData['lastname']}'
                          //     : '', //${userData['user_id']}
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: themeNotifier.lightTheme
                                ? Colors.white
                                : Color(0xff01A0C7),
                          ),
                        ),
                      ]),
                  accountEmail: Text(
                    feedsBox.get('name') == null ? '' : feedsBox.get('name'),
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: themeNotifier.lightTheme
                          ? Colors.white
                          : Color(
                              0xff01A0C7), //themeProvider.isLightTheme ? Colors.white:   Color(0xff01A0C7),
                    ),
                  ),
                  currentAccountPicture: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileSee()),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        backgroundImage: feedsBox.get('base64Imageconvert') !=
                                null
                            ? MemoryImage(
                                base64Decode(
                                  feedsBox.get('base64Imageconvert'),
                                ),
                              )
                            : NetworkImage(
                                userData != null ? userData['photo_path'] : '',
                                scale: 1.0),
                      ),
                    ),
                  ),
                ),

                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage2()),
                    );
                  },
                  leading: Icon(
                    Icons.home,
                    color: Color(0xff01A0C7),
                  ),
                  title: Text(
                    'Feeds',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w200,
                      color: Color(0xff01A0C7),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => //EditProfilePage()
                              UserProfileSee()), //EditProfilePage()
                    );
                  },
                  leading: Icon(
                    Icons.person,
                    color: Color(0xff01A0C7),
                  ),
                  title: Text(
                    'Profile',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w200,
                      color: Color(0xff01A0C7),
                    ),
                  ),
                ),

                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                  leading: Icon(
                    Icons.settings,
                    color: Color(0xff01A0C7),
                  ),
                  title: Text(
                    'Settings',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w200,
                      color: Color(0xff01A0C7),
                    ),
                  ),
                ),
                // SizedBox(height: 150),
                ListTile(
                  onTap: () {
                    Provider.of<Auth>(context, listen: false).logOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                  leading: Icon(
                    Icons.lock,
                    color: Color(0xff01A0C7),
                  ),
                  title: Text(
                    'Logout',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.w200,
                      color: Color(0xff01A0C7),
                    ),
                  ),
                ),
                //   ListTile(
                //     leading:  Switch(
                //  inactiveTrackColor: Color(0xff01A0C7),
                //  inactiveThumbColor: Color(0xff01A0C7),
                //  activeColor: Colors.white,
                //       value: themeProvider.isLightTheme,
                //       onChanged: (val) {
                //         themeProvider.setThemeData = val;
                //       },
                //     ),
                //      title: Text(
                //       'Change Theme',
                //       style: GoogleFonts.montserrat(
                //         fontSize: 17,
                //         fontWeight: FontWeight.w200,
                //         color: Color(0xff01A0C7),
                //       ),
                //     ),
                //   )
              ]),
        )),
      ),
    );
  }
}
