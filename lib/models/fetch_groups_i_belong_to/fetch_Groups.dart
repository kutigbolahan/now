library fetch;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nahere/models/fetch_groups_i_belong_to/serializers.dart';

part 'fetch_Groups.g.dart';

abstract class Fetch implements Built<Fetch, FetchBuilder> {
  Fetch._();

  factory Fetch([updates(FetchBuilder b)]) = _$Fetch;

  @BuiltValueField(wireName: 'status')
  int get status;
  @BuiltValueField(wireName: 'msg')
  String get msg;
  @BuiltValueField(wireName: 'data')
  BuiltList<Data> get data;
  String toJson() {
    return json.encode(serializers.serializeWith(Fetch.serializer, this));
  }

  static Fetch fromJson(String jsonString) {
    return serializers.deserializeWith(
        Fetch.serializer, json.decode(jsonString));
  }

  static Serializer<Fetch> get serializer => _$fetchSerializer;
}


abstract class Data implements Built<Data, DataBuilder> {
  Data._();

  factory Data([updates(DataBuilder b)]) = _$Data;

  @BuiltValueField(wireName: 'group_id')
  String get groupId;
  @BuiltValueField(wireName: 'group_name')
  String get groupName;
  @BuiltValueField(wireName: 'admin')
  String get admin;
  String toJson() {
    return json.encode(serializers.serializeWith(Data.serializer, this));
  }

  static Data fromJson(String jsonString) {
    return serializers.deserializeWith(
        Data.serializer, json.decode(jsonString));
  }

  static Serializer<Data> get serializer => _$dataSerializer;
}
