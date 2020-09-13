import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nahere/widgets/apptheme.dart';

import 'package:nahere/widgets/drawer.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'My Settings',
          style: GoogleFonts.montserrat(
              color: Color(0xff01A0C7),
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          trailing: Switch(
                            inactiveTrackColor: Color(0xff01A0C7),
                            inactiveThumbColor: Color(0xff01A0C7),
                            activeColor: Colors.grey,
                            value: themeNotifier.lightTheme,
                            onChanged: (val) {
                              themeNotifier.toggleTheme();
                              // themeProvider.setThemeData = val;

                              // final themeStateval = val;
                              // feedsBox2.put('AppthemeState', themeStateval);
                            },
                          ),
                          title: Text(
                            'Themes',
                            style: GoogleFonts.montserrat(
                                color: Color(0xff01A0C7),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            'Change your app theme. ',
                            style: GoogleFonts.montserrat(
                                color: themeNotifier.lightTheme
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: GestureDetector(
                            onTap: () {
                              showAboutDialog(
                                context: context,
                                applicationName: 'NaHere Limited',
                                applicationVersion: '1.0.0+1',
                                applicationLegalese:
                                    'A Product Of NaHere Limited.',
                                applicationIcon: Image.asset(
                                  'assets/appiconicon.png',
                                  height: 50,
                                  width: 50,
                                ),
                              );
                            },
                            child: Text(
                              'Licenses',
                              style: GoogleFonts.montserrat(
                                  color: Color(0xff01A0C7),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          subtitle: Text(
                            'Check app licences. ',
                            style: GoogleFonts.montserrat(
                                color: themeNotifier.lightTheme
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //     child: Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Icon(
                  //       Icons.copyright,
                  //       size: 10,
                  //       color: themeNotifier.lightTheme
                  //           ? Colors.grey
                  //           : Colors.white,
                  //     ),
                  //     Text(
                  //       'Property Of NaHere Limiteds.',
                  //       style: GoogleFonts.montserrat(
                  //           color: themeNotifier.lightTheme
                  //               ? Colors.grey
                  //               : Colors.white,
                  //           fontSize: 10,
                  //           fontWeight: FontWeight.w300),
                  //     )
                  //   ],
                  // ))
                ]),
          ),
        ),
      ),
    );
  }
}
