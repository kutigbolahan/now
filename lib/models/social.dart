class SocialFeeds1 {
  int status;
  String msg;
  List<Data> data;
  int totalRows;
  int numOfPages;

  SocialFeeds1(
      {this.status, this.msg, this.data, this.totalRows, this.numOfPages});

  SocialFeeds1.fromJson(Map<String, dynamic> json) {
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
  String group_id;
  String update_time;
  String firstname;
  String lastname;
  String profile_pic;
  String profession;
  List<SocialFiles> socialFiles;

  Data({
    this.id,
    this.updateBy,
    this.message,
    this.group_id,
    this.update_time,
    this.firstname,
    this.lastname,
    this.profile_pic,
    this.profession,
    this.socialFiles,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updateBy = json['update_by'];
    message = json['message'];
    group_id = json['group_id'];
    update_time = json['update_time'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    profile_pic = json['profile_pic'];
    profession = json['profession'];
    if (json['socialFiles'] != null) {
      socialFiles = new List<SocialFiles>();
      json['socialFiles'].forEach((v) {
        socialFiles.add(new SocialFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['update_by'] = this.updateBy;
    data['message'] = this.message;
    data['group_id'] = this.group_id;
    data['update_time'] = this.update_time;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['profile_pic'] = this.profile_pic;
    data['profession'] = this.profession;
    if (this.socialFiles != null) {
      data['socialFiles'] = this.socialFiles.map((v) => v.toJson()).toList();
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
