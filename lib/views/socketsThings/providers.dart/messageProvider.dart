import 'package:flutter/foundation.dart';
import 'package:nahere/views/socketsThings/model/message.dart';

class MessagesProvider with ChangeNotifier {
  final List<dynamic> _messages = [];

  List<dynamic> get allMessages => [..._messages];

  addMessage(dynamic message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
