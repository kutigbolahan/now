import 'dart:io';

//import 'package:device_preview/device_preview.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/controllers/auth/auth.dart';
import 'package:nahere/views/socketsThings/providers.dart/messageProvider.dart';
import 'package:nahere/widgets/apptheme.dart';

import 'package:nahere/widgets/utility.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import 'controllers/auth/sessions_page.dart';
import 'views/registrationpages/register_page.dart';
import 'package:nahere/views/pages/onboarding.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

int initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  await Hive.initFlutter();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>('feedsApp');
  await FlutterDownloader.initialize(
      debug:
          false // optional: set false to disable printing logs to console //make it false in production
      );
  //to lock lanscape mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

//     MyApp(),
//     //   DevicePreview(
//     //   builder: (context)=>MyApp(),
//     //   enabled: !kReleaseMode,
//     //  )
//   );
// }
  runApp(
    // ChangeNotifierProvider(
    //   create: (_) => ThemeProvider(isLightTheme: true),
    ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: MyApp()),
    //   DevicePreview(
    //   builder: (context)=>MyApp(),
    //   enabled: !kReleaseMode,
    //  )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CallApi()),
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => MessagesProvider()),
        ChangeNotifierProvider(create: (context) => Utility()),
        // ChangeNotifierProvider<HttpService>(
        //   create: (context) => HttpService(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.lightTheme ? light : dark,
        home:
            initScreen == 0 || initScreen == null ? SplashScreen() : Sessions(),

        routes: {
          // RegisterPage.routeName: (context) => RegisterPage(),
          RegisterPage.routeName: (context) => RegisterPage(),
        },
        // channel: IOWebSocketChannel.connect('ws://echo.websocket.org'),
      ),
    );
  }
}
