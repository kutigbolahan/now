import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:nahere/controllers/api.dart';
import 'package:nahere/models/fetch_groups_i_belong_to/fetch_Groups.dart';
import 'package:nahere/models/fetch_groups_i_belong_to/serializers.dart';
//import 'package:nahere/models/findpeopleModel.dart';
import 'package:nahere/models/social.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ServiceApi extends ChangeNotifier {
  Box<String> feedsBox = Hive.box('feedsApp');
  // FindPeoples _findPeople;

  databasesaves(String m) {
    feedsBox.get(m);
    notifyListeners();
  }

  Future<Fetch> fetchGroupsUsersBelongTo(BuildContext context) async {
    //print('${userData['user_id']}');
    try {
      var res = await Provider.of<CallApi>(context)
          .getData('social/fetch_groups_i_belong_to?user=117');
      // social/fetch_groups_i_belong_to?user=${userData['user_id']}
      //final response = serializers.deserialize(json.decode(res.body),specifiedType: new FullType(SocialFeeds));
      //print('${userData['user_id']}');
      Fetch fetch = standardSerializers.deserializeWith(
        Fetch.serializer,
        json.decode(res.body),
      );
      notifyListeners();
      return fetch;
    } catch (e) {
      print(e);
      return e.message;
    }
  }

  Future deletePost(BuildContext context) async {
    var data = {
      'user_id': '${feedsBox.get('userID')}',
      'post_id': '${feedsBox.get('uniqueDelId')}',
      'group_id': '${feedsBox.get('deletegroupId')}',
    };
    try {
      var response = await Provider.of<CallApi>(context, listen: false)
          .postData(data, 'social/delete_update');
      // var response = await http.delete(
      //     'https://empl-dev.site/api/social/delete_update/user_id=117&post_id=618&group_id=0');
      var body = jsonDecode(response.body);

      if (body['msg'] == "Successful") {
        print('deleted successful');
        //  _showToast(context, body['msg']);
      } else {
        print('deleted not');
        // _showToast(context, body['msg']);
      }
    } catch (e) {
      print(e);
      return e;
    }

    //return null;
  }

  // Future<FindPeoples> findPeople(BuildContext context) async {
  //   String url =
  //       'https://empl-dev.site/api/social/findPeople?term=${feedsBox.get('searchVal')}';
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       _findPeople = FindPeoples.fromJson(data);
  //     }
  //     notifyListeners();
  //     return _findPeople;
  //   } catch (e) {
  //     print(e);
  //     return e;
  //   }
  // }
}
