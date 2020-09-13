import 'dart:convert';

class Message {
  final String message;
  // final String post;
  final String group;
  // final String user;
  final String responding_to;
  final String update_by;
  final String profile_pic;
  final String first_name;
  final String last_name;
  // final String reply_n;
  //final String name_n;
  //final String msg;
  final dynamic post_id;
  final String profession_n;
  final DateTime time;

  const Message({
    this.message,
    // this.post,
    this.group,
    //this.user,
    this.responding_to,
    this.update_by,
    this.profile_pic,
    this.first_name,
    this.last_name,
    // this.reply_n,
    // this.name_n,
    // this.msg,
    this.post_id,
    this.profession_n,
    this.time,
  });

  bool isUserMessage(String message) => this.message == message;

  String toJson() => json.encode({
        'message': message,
        // 'post': post,
        'group': group,
        // 'user': group,
        'responding_to': responding_to,
        'update_by': update_by,
        'profile_pic': profile_pic,
        'first_name': first_name,
        'last_name': last_name,
        // 'reply_n': reply_n,
        // 'name_n': name_n,
        // 'msg': msg,
        'post_id': post_id,
        'profession_n': profession_n,
        'time': time.toString(),
      });

  static Message fromJson(Map<String, dynamic> socketdata) {
    return Message();
    //  Message(
    //   socketdata['message'],
    //   // socketdata['post'],
    //   socketdata['group'],
    //   // socketdata['user'],
    //   socketdata['responding_to'],
    //   socketdata['update_by'],
    //   socketdata['profile_pic'],
    //   socketdata['first_name'],
    //   socketdata['last_name'],
    //   // socketdata['reply_n'],
    //   // socketdata['name_n'],
    //   // socketdata['msg'],
    //   socketdata['post_id'],
    //   socketdata['profession_n'],
    //   DateTime.parse(socketdata['time']),
    // );
  }
}
