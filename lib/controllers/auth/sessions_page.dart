import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nahere/views/pages/homepage2.dart';
import 'package:nahere/views/pages/homepage3.dart';

import 'package:nahere/views/registrationpages/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class Sessions extends StatefulWidget {
  final WebSocketChannel channel;
  Sessions({this.channel});
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  WebSocketChannel channel;
  var timer;
// Box<bool> sessionsState;
  @override
  void initState() {
    //  _getLoginState();
    timer = Timer(Duration(milliseconds: 100), () {
      _getLoginState();
    });

    super.initState();
  }

  @override
  void dispose() {
    // timer.dispose();
    super.dispose();
  }

  Future _getLoginState() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var _sessions = _prefs.getString('data');

    if (_sessions != null) {
      final page = HomePage3(
          //  channel: IOWebSocketChannel.connect('ws://api.empl-dev.site:443'),
          );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => page));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    // channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    return Scaffold(
        // channel: IOWebSocketChannel.connect('ws://echo.websocket.org'),
        );
  }
}
