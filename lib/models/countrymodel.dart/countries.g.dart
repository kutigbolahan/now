// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Countries> _$countriesSerializer = new _$CountriesSerializer();
Serializer<Data> _$dataSerializer = new _$DataSerializer();

class _$CountriesSerializer implements StructuredSerializer<Countries> {
  @override
  final Iterable<Type> types = const [Countries, _$Countries];
  @override
  final String wireName = 'Countries';

  @override
  Iterable<Object> serialize(Serializers serializers, Countries object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Data)])));
    }
    return result;
  }

  @override
  Countries deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CountriesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Data)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$DataSerializer implements StructuredSerializer<Data> {
  @override
  final Iterable<Type> types = const [Data, _$Data];
  @override
  final String wireName = 'Data';

  @override
  Iterable<Object> serialize(Serializers serializers, Data object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.countryCode != null) {
      result
        ..add('country_code')
        ..add(serializers.serialize(object.countryCode,
            specifiedType: const FullType(String)));
    }
    if (object.countryName != null) {
      result
        ..add('country_name')
        ..add(serializers.serialize(object.countryName,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Data deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'country_code':
          result.countryCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country_name':
          result.countryName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Countries extends Countries {
  @override
  final BuiltList<Data> data;

  factory _$Countries([void Function(CountriesBuilder) updates]) =>
      (new CountriesBuilder()..update(updates)).build();

  _$Countries._({this.data}) : super._();

  @override
  Countries rebuild(void Function(CountriesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountriesBuilder toBuilder() => new CountriesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Countries && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Countries')..add('data', data))
        .toString();
  }
}

class CountriesBuilder implements Builder<Countries, CountriesBuilder> {
  _$Countries _$v;

  ListBuilder<Data> _data;
  ListBuilder<Data> get data => _$this._data ??= new ListBuilder<Data>();
  set data(ListBuilder<Data> data) => _$this._data = data;

  CountriesBuilder();

  CountriesBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Countries other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Countries;
  }

  @override
  void update(void Function(CountriesBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Countries build() {
    _$Countries _$result;
    try {
      _$result = _$v ?? new _$Countries._(data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Countries', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Data extends Data {
  @override
  final String countryCode;
  @override
  final String countryName;

  factory _$Data([void Function(DataBuilder) updates]) =>
      (new DataBuilder()..update(updates)).build();

  _$Data._({this.countryCode, this.countryName}) : super._();

  @override
  Data rebuild(void Function(DataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DataBuilder toBuilder() => new DataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Data &&
        countryCode == other.countryCode &&
        countryName == other.countryName;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, countryCode.hashCode), countryName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Data')
          ..add('countryCode', countryCode)
          ..add('countryName', countryName))
        .toString();
  }
}

class DataBuilder implements Builder<Data, DataBuilder> {
  _$Data _$v;

  String _countryCode;
  String get countryCode => _$this._countryCode;
  set countryCode(String countryCode) => _$this._countryCode = countryCode;

  String _countryName;
  String get countryName => _$this._countryName;
  set countryName(String countryName) => _$this._countryName = countryName;

  DataBuilder();

  DataBuilder get _$this {
    if (_$v != null) {
      _countryCode = _$v.countryCode;
      _countryName = _$v.countryName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Data other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Data;
  }

  @override
  void update(void Function(DataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Data build() {
    final _$result =
        _$v ?? new _$Data._(countryCode: countryCode, countryName: countryName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
