import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:nahere/models/social.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  Future logOut() async {
    SharedPreferences _logoutPrefs = await SharedPreferences.getInstance();
    //_logoutPrefs.clear();
    _logoutPrefs.remove('data');
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EditProfileValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Fields can't be empty";
    }

    return null;
  }
}

class EmailValidator {
  static String validate(String value) {
    if (!value.contains('@')) {
      return 'E-mail is invalid';
    } else if (!value.contains('.')) {
      return 'E-mail is invalid';
    } else if (value.isEmpty) {
      return 'E-mail cant be empty';
    } else if (!value.contains('.com')) {
      return 'E-mail is invalid';
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 6) {
      return 'password must be more than 6';
    }

    return null;
  }
}

class EmailCodeRecovery {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Field can't be empty";
    }

    return null;
  }
}

class Validations {
  String validatesubtitle(String value) {
    if (value.contains('<>')) return null;
    final RegExp nameExp = new RegExp(r'^[a-zA-Z0-9]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }
}

class PhoneNumberValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Fields can't be empty";
    }
    if (value.length < 11) {
      return 'Invalid Phone Number';
    }
    if (value.length > 11) {
      return 'Invalid Phone Number';
    }
    return null;
  }
}

class PhoneNumberValidator1 {
  static String validatePhoneNumber(String value) {
    String pattern = r'(^(08)|(09)|(07)(?:[0-9] ?){6,14}[0-9]$)';
    RegExp regExp = RegExp(pattern);
    if (value.length == 0) {
      return "Enter mobile number";
    }
    if (!regExp.hasMatch(value.trim())) {
      return "Enter valid mobile number";
    }
    if (value.isEmpty) {
      return "Fields can't be empty";
    }
    if (value.length < 11) {
      return 'Invalid Phone Number';
    }
    if (value.length > 11) {
      return 'Invalid Phone Number';
    }
    return null;
  }
}

// class DifferentGroupsFeedstest extends ChangeNotifier {
//   dynamic data;
//   Box<String> feedsBox;
//   var listOfImages = [];
//   Future<SocialFeeds1> differentGroupfeeds1() async {
//     final response = await http.get(
//         //'https://empl-dev.site/api/social/fetch_updates?user=${userData['user_id']}&group_id=0&page=0&limit=25');
//         // 'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=0&page=0&limit=25');
//         // 'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=14&page=0&limit=25');
//         // ${group_id[group_id]}
//         'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=${feedsBox.get('GROUPIDEACH')}&page=0&limit=25');
//     // 'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=$feedsBox.get(groupId)&page=1&limit=25');

//     if (response.statusCode == 200) {
//       //  return SocialFeeds1.fromJson(json.decode(response.body));
//       data = json.decode(response.body);
//       var data2 = json.decode(response.body)['data'];
//       var res = SocialFeeds1.fromJson(data);
//       notifyListeners();
//       for (int index = 0; index < data2.length; index++) {
//         if (data2[index]['socialFiles'] != null) {
//           for (int i = 0; i < data2[index]['socialFiles'].length; i++) {
//             listOfImages.add(data2[index]['socialFiles'][i]['val']);
//           }
//         }
//       }

//       // final apiresonse = res;
//       // feedsBox.put('apiResponseForIntialData', apiresonse.toString());
//       return res;
//       //  return SocialFeeds1.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to load feeds');
//     }
//   }
// }

//Box<String> feedsBox = Hive.box('feedsApp');

// var listOfImages = [];
// dynamic data;
// // feedsBox = Hive.box('feedsApp');

// class HttpService extends ChangeNotifier {
//   Future<SocialFeeds1> publicFeeds() async {
//     final response = await http.get(
//         //'https://empl-dev.site/api/social/fetch_updates?user=${feedsBox.get('userID')}&group_id=0&page=0&limit=25'
//         'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=0&page=0&limit=25');

//     //'https://empl-dev.site/api/social/fetch_updates?user=117&group_id=0&page=0&limit=250000000000');
//     //'https://empl-dev.site/api/social/fetch_updates?user=45&group_id=snapshot.data.data[index].group_id&page=0&limit=25');

//     if (response.statusCode == 200) {
//       // print('${userData['user_id']}');
//       // print( SocialFeeds1.fromJson(json.decode(response.body)));
//       data = json.decode(response.body);
//       var data2 = json.decode(response.body)['data'];
//       notifyListeners();
//       var res = SocialFeeds1.fromJson(data);

//       for (int index = 0; index < data2.length; index++) {
//         if (data2[index]['socialFiles'] != null) {
//           for (int i = 0; i < data2[index]['socialFiles'].length; i++) {
//             listOfImages.add(data2[index]['socialFiles'][i]['val']);
//           }
//         }
//       }

//       return res;
//     } else {
//       throw Exception('Failed to load feeds');
//     }
//   }
// }

// enum DownloadStatus { NotStarted, Started, Downloading, Completed }

// class FileDownloaderProvider with ChangeNotifier {
//   StreamSubscription _downloadSubscription;
//   DownloadStatus _downloadStatus = DownloadStatus.NotStarted;
//   int _downloadPercentage = 0;
//   String _downloadedFile = "";

//   int get downloadPercentage => _downloadPercentage;
//   DownloadStatus get downloadStatus => _downloadStatus;
//   String get downloadedFile => _downloadedFile;

//   Future downloadFile(String url, String filename) async {
//     bool _permissionReady = await _checkPermission();
//     final Completer<void> completer = Completer<void>();

//     if (!_permissionReady) {
//       _checkPermission().then((hasGranted) {
//         _permissionReady = hasGranted;
//       });
//     } else {
//       var httpClient = http.Client();
//       var request = new http.Request('GET', Uri.parse(url));
//       var response = httpClient.send(request);

//       final dir = Platform.isAndroid
//           ? '/sdcard/download'
//           : (await getApplicationDocumentsDirectory()).path;

//       List<List<int>> chunks = new List();
//       int downloaded = 0;

//       updateDownloadStatus(DownloadStatus.Started);

//       _downloadSubscription =
//           response.asStream().listen((http.StreamedResponse r) {
//         updateDownloadStatus(DownloadStatus.Downloading);
//         r.stream.listen((List<int> chunk) async {
//           // Display percentage of completion
//           print('downloadPercentage onListen : $_downloadPercentage');

//           chunks.add(chunk);
//           downloaded += chunk.length;
//           _downloadPercentage = (downloaded / r.contentLength * 100).round();
//           notifyListeners();
//         }, onDone: () async {
//           // Display percentage of completion
//           _downloadPercentage = (downloaded / r.contentLength * 100).round();
//           notifyListeners();
//           print('downloadPercentage onDone: $_downloadPercentage');

//           // Save the file
//           File file = new File('$dir/$filename');

//           _downloadedFile = '$dir/$filename';
//           print(_downloadedFile);

//           final Uint8List bytes = Uint8List(r.contentLength);
//           int offset = 0;
//           for (List<int> chunk in chunks) {
//             bytes.setRange(offset, offset + chunk.length, chunk);
//             offset += chunk.length;
//           }
//           await file.writeAsBytes(bytes);

//           updateDownloadStatus(DownloadStatus.Completed);
//           _downloadSubscription?.cancel();
//           _downloadPercentage = 0;

//           notifyListeners();
//           print('DownloadFile: Completed');
//           completer.complete();

//           return;
//         });
//       });
//     }

//     await completer.future;
//   }

//   void updateDownloadStatus(DownloadStatus status) {
//     _downloadStatus = status;
//     print('updateDownloadStatus: $status');
//     notifyListeners();
//   }

//   Future<bool> _checkPermission() async {
//     PermissionStatus permission = await PermissionStatus()
//         .checkPermissionStatus(PermissionGroup.storage);
//     if (permission != PermissionStatus.granted) {
//       Map<PermissionGroup, PermissionStatus> permissions =
//           await PermissionHandler()
//               .requestPermissions([PermissionGroup.storage]);
//       if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
//         return true;
//       }
//     } else {
//       return true;
//     }

//     return false;
//   }
// }
