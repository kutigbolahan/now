// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeds.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Feeds> _$feedsSerializer = new _$FeedsSerializer();
Serializer<Data> _$dataSerializer = new _$DataSerializer();

class _$FeedsSerializer implements StructuredSerializer<Feeds> {
  @override
  final Iterable<Type> types = const [Feeds, _$Feeds];
  @override
  final String wireName = 'Feeds';

  @override
  Iterable<Object> serialize(Serializers serializers, Feeds object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Data)])),
    ];

    return result;
  }

  @override
  Feeds deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FeedsBuilder();

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
    if (object.actionTime != null) {
      result
        ..add('action_time')
        ..add(serializers.serialize(object.actionTime,
            specifiedType: const FullType(String)));
    }
    if (object.doneBy != null) {
      result
        ..add('done_by')
        ..add(serializers.serialize(object.doneBy,
            specifiedType: const FullType(String)));
    }
    if (object.profilePicPath != null) {
      result
        ..add('profile_pic_path')
        ..add(serializers.serialize(object.profilePicPath,
            specifiedType: const FullType(String)));
    }
    if (object.message != null) {
      result
        ..add('message')
        ..add(serializers.serialize(object.message,
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
        case 'action_time':
          result.actionTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'done_by':
          result.doneBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'profile_pic_path':
          result.profilePicPath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Feeds extends Feeds {
  @override
  final BuiltList<Data> data;

  factory _$Feeds([void Function(FeedsBuilder) updates]) =>
      (new FeedsBuilder()..update(updates)).build();

  _$Feeds._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('Feeds', 'data');
    }
  }

  @override
  Feeds rebuild(void Function(FeedsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedsBuilder toBuilder() => new FeedsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Feeds && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Feeds')..add('data', data)).toString();
  }
}

class FeedsBuilder implements Builder<Feeds, FeedsBuilder> {
  _$Feeds _$v;

  ListBuilder<Data> _data;
  ListBuilder<Data> get data => _$this._data ??= new ListBuilder<Data>();
  set data(ListBuilder<Data> data) => _$this._data = data;

  FeedsBuilder();

  FeedsBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Feeds other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Feeds;
  }

  @override
  void update(void Function(FeedsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Feeds build() {
    _$Feeds _$result;
    try {
      _$result = _$v ?? new _$Feeds._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Feeds', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Data extends Data {
  @override
  final String actionTime;
  @override
  final String doneBy;
  @override
  final String profilePicPath;
  @override
  final String message;

  factory _$Data([void Function(DataBuilder) updates]) =>
      (new DataBuilder()..update(updates)).build();

  _$Data._({this.actionTime, this.doneBy, this.profilePicPath, this.message})
      : super._();

  @override
  Data rebuild(void Function(DataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DataBuilder toBuilder() => new DataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Data &&
        actionTime == other.actionTime &&
        doneBy == other.doneBy &&
        profilePicPath == other.profilePicPath &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, actionTime.hashCode), doneBy.hashCode),
            profilePicPath.hashCode),
        message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Data')
          ..add('actionTime', actionTime)
          ..add('doneBy', doneBy)
          ..add('profilePicPath', profilePicPath)
          ..add('message', message))
        .toString();
  }
}

class DataBuilder implements Builder<Data, DataBuilder> {
  _$Data _$v;

  String _actionTime;
  String get actionTime => _$this._actionTime;
  set actionTime(String actionTime) => _$this._actionTime = actionTime;

  String _doneBy;
  String get doneBy => _$this._doneBy;
  set doneBy(String doneBy) => _$this._doneBy = doneBy;

  String _profilePicPath;
  String get profilePicPath => _$this._profilePicPath;
  set profilePicPath(String profilePicPath) =>
      _$this._profilePicPath = profilePicPath;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  DataBuilder();

  DataBuilder get _$this {
    if (_$v != null) {
      _actionTime = _$v.actionTime;
      _doneBy = _$v.doneBy;
      _profilePicPath = _$v.profilePicPath;
      _message = _$v.message;
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
    final _$result = _$v ??
        new _$Data._(
            actionTime: actionTime,
            doneBy: doneBy,
            profilePicPath: profilePicPath,
            message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
