import 'package:flutter/foundation.dart';
import 'package:nahere/views/socketsThings/model/message.dart';

class MessagesProvider with ChangeNotifier {
  final List<dynamic> _messages = [];
  // final List<dynamic> _socialfeeds = [];

  List<dynamic> get allMessages => [..._messages];
  //List<dynamic> get socialMessages => [..._socialfeeds];

  addMessage(dynamic message) {
    _messages.insert(0, message);
    //_socialfeeds.insert(0, message);
    notifyListeners();
  }
}
