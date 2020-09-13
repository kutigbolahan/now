import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nahere/models/countrymodel.dart/serializers.dart';

part 'countries.g.dart';

abstract class Countries implements Built<Countries, CountriesBuilder> {
  // Fields
  @nullable
  BuiltList<Data> get data;
  Countries._();

  factory Countries([void Function(CountriesBuilder) updates]) = _$Countries;

  String toJson() {
    return json.encode(serializers.serializeWith(Countries.serializer, this));
  }

  static Countries fromJson(String jsonString) {
    return serializers.deserializeWith(
        Countries.serializer, json.decode(jsonString));
  }

  static Serializer<Countries> get serializer => _$countriesSerializer;
}

abstract class Data implements Built<Data, DataBuilder> {
  // Fields
//@BuiltValueField(wireName: 'country_id')
  //String  get countryId;
  
  @BuiltValueField(wireName: 'country_code')
  @nullable
  String get countryCode;

  @BuiltValueField(wireName: 'country_name')
  @nullable
  String get countryName;

  Data._();

  factory Data([void Function(DataBuilder) updates]) = _$Data;

  String toJson() {
    return json.encode(serializers.serializeWith(Data.serializer, this));
  }

  static Data fromJson(String jsonString) {
    return serializers.deserializeWith(
        Data.serializer, json.decode(jsonString));
  }

  static Serializer<Data> get serializer => _$dataSerializer;
}
