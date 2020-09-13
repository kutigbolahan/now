library social_feeds;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nahere/models/social/serializers.dart';

part 'socialfeeds.g.dart';

abstract class SocialFeeds implements Built<SocialFeeds, SocialFeedsBuilder> {
  SocialFeeds._();

  factory SocialFeeds([updates(SocialFeedsBuilder b)]) = _$SocialFeeds;

  @BuiltValueField(wireName: 'status')
  int get status;
  @BuiltValueField(wireName: 'msg')
  String get msg;
  @BuiltValueField(wireName: 'data')
  BuiltList<Data> get data;
  @BuiltValueField(wireName: 'total_rows')
  int get totalRows;
  @BuiltValueField(wireName: 'num_of_pages')
  int get numOfPages;
  @BuiltValueField(wireName: 'q')
  String get q;
  String toJson() {
    return json.encode(serializers.serializeWith(SocialFeeds.serializer, this));
  }

  static SocialFeeds fromJson(String jsonString) {
    return serializers.deserializeWith(
        SocialFeeds.serializer, json.decode(jsonString));
  }

  static Serializer<SocialFeeds> get serializer => _$socialFeedsSerializer;
}
// library data;

// import 'dart:convert';

// import 'package:built_collection/built_collection.dart';
// import 'package:built_value/built_value.dart';
// import 'package:built_value/serializer.dart';

// part 'data.g.dart';

abstract class Data implements Built<Data, DataBuilder> {
  Data._();

  factory Data([updates(DataBuilder b)]) = _$Data;

  // @BuiltValueField(wireName: 'id')
  // String get id;
  // @BuiltValueField(wireName: 'update_by')
  // String get updateBy;
  @BuiltValueField(wireName: 'message')
  String get message;
  // @BuiltValueField(wireName: 'group_id')
  // String get groupId;
  @BuiltValueField(wireName: 'update_time')
  String get updateTime;
  @BuiltValueField(wireName: 'firstname')
  String get firstname;
  @BuiltValueField(wireName: 'lastname')
  String get lastname;
  @BuiltValueField(wireName: 'profile_pic')
  String get profilePic;
  @BuiltValueField(wireName: 'profession')
  String get profession;
  @BuiltValueField(wireName: 'images')
  BuiltList<String> get images;
  String toJson() {
    return json.encode(serializers.serializeWith(Data.serializer, this));
  }

  static Data fromJson(String jsonString) {
    return serializers.deserializeWith(
        Data.serializer, json.decode(jsonString));
  }

  static Serializer<Data> get serializer => _$dataSerializer;
}
