import 'dart:convert';

UserProfiless userProfilessFromJson(String str) => UserProfiless.fromJson(json.decode(str));

String userProfilessToJson(UserProfiless data) => json.encode(data.toJson());

class UserProfiless {
    UserProfiless({
        this.data,
        this.status,
        this.msg,
    });

    Data data;
    String status;
    String msg;

    factory UserProfiless.fromJson(Map<String, dynamic> json) => UserProfiless(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "msg": msg,
    };
}

class Data {
    Data({
        this.firstname,
        this.lastname,
        this.othernames,
        this.email,
        this.phone,
        this.gender,
        this.dob,
        this.pics,
    });

    String firstname;
    String lastname;
    String othernames;
    String email;
    String phone;
    String gender;
    String dob;
    String pics;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstname: json["firstname"],
        lastname: json["lastname"],
        othernames: json["othernames"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
        dob: json["dob"],
        pics: json["pics"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "othernames": othernames,
        "email": email,
        "phone": phone,
        "gender": gender,
        "dob": dob,
        "pics": pics,
    };
}
