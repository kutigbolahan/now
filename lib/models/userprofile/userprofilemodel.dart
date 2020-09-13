// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';
// import 'package:nahere/models/userprofile/serializers.dart';


// part 'userprofilemodel.g.dart';

// abstract class UserProfile implements Built<UserProfile, UserProfileBuilder> {
//   // Fields
//   BuiltList<UserData> get data;

//   UserProfile._();

//   factory UserProfile([void Function(UserProfileBuilder) updates]) =
//       _$UserProfile;

//   String toJson() {
//     return json.encode(serializers.serializeWith(UserProfile.serializer, this));
//   }

//   static UserProfile fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         UserProfile.serializer, json.decode(jsonString));
//   }

//   static Serializer<UserProfile> get serializer => _$userProfileSerializer;
// }

// abstract class UserData implements Built<UserData, UserDataBuilder> {
//   // Fields
//   String get firstname;
//   String get lastname;
//   String get othernames;
//   String get email;
//   String get phone;
//   String get gender;
//   String get dob;
//   String get pics;

//   UserData._();

//   factory UserData([void Function(UserDataBuilder) updates]) = _$UserData;

//   String toJson() {
//     return json.encode(serializers.serializeWith(UserData.serializer, this));
//   }

//   static UserData fromJson(String jsonString) {
//     return serializers.deserializeWith(
//         UserData.serializer, json.decode(jsonString));
//   }

//   static Serializer<UserData> get serializer => _$userDataSerializer;
// }

library user_profile;

import 'dart:convert';


import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nahere/models/userprofile/serializers.dart';

part 'userprofilemodel.g.dart';

abstract class UserProfile implements Built<UserProfile, UserProfileBuilder> {
  UserProfile._();

  factory UserProfile([updates(UserProfileBuilder b)]) = _$UserProfile;

  @BuiltValueField(wireName: 'data')
  Data get data;
  @BuiltValueField(wireName: 'status')
  String get status;
  @BuiltValueField(wireName: 'msg')
  String get msg;
  String toJson() {
    return json.encode(serializers.serializeWith(UserProfile.serializer, this));
  }

  static UserProfile fromJson(String jsonString) {
    return serializers.deserializeWith(
        UserProfile.serializer, json.decode(jsonString));
  }

  static Serializer<UserProfile> get serializer => _$userProfileSerializer;
}


abstract class Data implements Built<Data, DataBuilder> {
  Data._();

  factory Data([updates(DataBuilder b)]) = _$Data;

  @BuiltValueField(wireName: 'firstname')
  String get firstname;
  @BuiltValueField(wireName: 'lastname')
  String get lastname;
  @BuiltValueField(wireName: 'othernames')
  String get othernames;
  @BuiltValueField(wireName: 'email')
  String get email;
  @BuiltValueField(wireName: 'phone')
  String get phone;
  @BuiltValueField(wireName: 'gender')
  String get gender;
  @BuiltValueField(wireName: 'dob')
  String get dob;
  @BuiltValueField(wireName: 'pics')
  String get pics;
  String toJson() {
    return json.encode(serializers.serializeWith(Data.serializer, this));
  }

  static Data fromJson(String jsonString) {
    return serializers.deserializeWith(
        Data.serializer, json.decode(jsonString));
  }

  static Serializer<Data> get serializer => _$dataSerializer;
}
