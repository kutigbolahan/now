import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'feeds.g.dart';

abstract class Feeds implements Built<Feeds, FeedsBuilder> {
  // Fields
  BuiltList<Data> get data;

  Feeds._();

  factory Feeds([void Function(FeedsBuilder) updates]) = _$Feeds;



  static Serializer<Feeds> get serializer => _$feedsSerializer;
}

abstract class Data implements Built<Data, DataBuilder> {
 // @nullable
  //String get module_name;
  @BuiltValueField(wireName: 'action_time')
  @nullable
 String get actionTime;
 // @nullable
 // String get formatted_action_time;
 @BuiltValueField(wireName: 'done_by')
  @nullable
  String get doneBy;
 // @nullable
 // String get profile_pic;
 @BuiltValueField(wireName: 'profile_pic_path')
  @nullable
  String get profilePicPath;
 // @nullable
 // int get ref_id;
  @nullable
  String get message;
 // @nullable
 // String get landing_page;
 // @nullable
 // String get feed_id;

  Data._();

  factory Data([void Function(DataBuilder) updates]) = _$Data;

  // String toJson() {
  //   return json.encode(serializers.serializeWith(Data.serializer, this));
  // }

  // static Data fromJson(String jsonString) {
  //   return serializers.deserializeWith(
  //       Data.serializer, json.decode(jsonString));
  // }

  static Serializer<Data> get serializer => _$dataSerializer;
}
