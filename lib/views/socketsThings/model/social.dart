class SocialFeeds2 {
  int status;
  String msg;
  List<Data> data;
  int totalRows;
  int numOfPages;

  SocialFeeds2(
      {this.status, this.msg, this.data, this.totalRows, this.numOfPages});

  SocialFeeds2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    totalRows = json['total_rows'];
    numOfPages = json['num_of_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total_rows'] = this.totalRows;
    data['num_of_pages'] = this.numOfPages;
    return data;
  }
}

class Data {
  String id;
  String updateBy;
  String message;
  String groupId;
  String updateTime;
  String firstname;
  String lastname;
  String profilePic;
  String profession;
  String uniqueId;
  String replyToPost;
  String replyToText;
  String replyToFirstname;
  String replyToLastname;
  List<dynamic> socialFiles;
  List<SocialFileNames> socialFileNames;

  Data(
      {this.id,
      this.updateBy,
      this.message,
      this.groupId,
      this.updateTime,
      this.firstname,
      this.lastname,
      this.profilePic,
      this.profession,
      this.uniqueId,
      this.replyToPost,
      this.replyToText,
      this.replyToFirstname,
      this.replyToLastname,
      this.socialFiles,
      this.socialFileNames});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updateBy = json['update_by'];
    message = json['message'];
    groupId = json['group_id'];
    updateTime = json['update_time'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    profilePic = json['profile_pic'];
    profession = json['profession'];
    uniqueId = json['unique_id'];
    replyToPost = json['reply_to_post'];
    replyToText = json['reply_to_text'];
    replyToFirstname = json['reply_to_firstname'];
    replyToLastname = json['reply_to_lastname'];
    if (json['socialFiles'] != null) {
      socialFiles = new List<SocialFiles>();
      json['socialFiles'].forEach((v) {
        socialFiles.add(new SocialFiles.fromJson(v));
      });
    }
    if (json['socialFile_names'] != null) {
      socialFileNames = new List<SocialFileNames>();
      json['socialFile_names'].forEach((v) {
        socialFileNames.add(new SocialFileNames.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['update_by'] = this.updateBy;
    data['message'] = this.message;
    data['group_id'] = this.groupId;
    data['update_time'] = this.updateTime;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['profile_pic'] = this.profilePic;
    data['profession'] = this.profession;
    data['unique_id'] = this.uniqueId;
    data['reply_to_post'] = this.replyToPost;
    data['reply_to_text'] = this.replyToText;
    data['reply_to_firstname'] = this.replyToFirstname;
    data['reply_to_lastname'] = this.replyToLastname;
    if (this.socialFiles != null) {
      data['socialFiles'] = this.socialFiles.map((v) => v.toJson()).toList();
    }
    if (this.socialFileNames != null) {
      data['socialFile_names'] =
          this.socialFileNames.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialFiles {
  String val;

  SocialFiles({this.val});

  SocialFiles.fromJson(Map<String, dynamic> json) {
    val = json['val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['val'] = this.val;
    return data;
  }
}

class SocialFileNames {
  String val;

  SocialFileNames({this.val});

  SocialFileNames.fromJson(Map<String, dynamic> json) {
    val = json['val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['val'] = this.val;
    return data;
  }
}
