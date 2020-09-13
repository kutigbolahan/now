// GENERATED CODE - DO NOT MODIFY BY HAND

part of fetch;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Fetch> _$fetchSerializer = new _$FetchSerializer();
Serializer<Data> _$dataSerializer = new _$DataSerializer();

class _$FetchSerializer implements StructuredSerializer<Fetch> {
  @override
  final Iterable<Type> types = const [Fetch, _$Fetch];
  @override
  final String wireName = 'Fetch';

  @override
  Iterable<Object> serialize(Serializers serializers, Fetch object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'status',
      serializers.serialize(object.status, specifiedType: const FullType(int)),
      'msg',
      serializers.serialize(object.msg, specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Data)])),
    ];

    return result;
  }

  @override
  Fetch deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FetchBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'msg':
          result.msg = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
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
    final result = <Object>[
      'group_id',
      serializers.serialize(object.groupId,
          specifiedType: const FullType(String)),
      'group_name',
      serializers.serialize(object.groupName,
          specifiedType: const FullType(String)),
      'admin',
      serializers.serialize(object.admin,
          specifiedType: const FullType(String)),
    ];

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
        case 'group_id':
          result.groupId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'group_name':
          result.groupName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'admin':
          result.admin = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Fetch extends Fetch {
  @override
  final int status;
  @override
  final String msg;
  @override
  final BuiltList<Data> data;

  factory _$Fetch([void Function(FetchBuilder) updates]) =>
      (new FetchBuilder()..update(updates)).build();

  _$Fetch._({this.status, this.msg, this.data}) : super._() {
    if (status == null) {
      throw new BuiltValueNullFieldError('Fetch', 'status');
    }
    if (msg == null) {
      throw new BuiltValueNullFieldError('Fetch', 'msg');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('Fetch', 'data');
    }
  }

  @override
  Fetch rebuild(void Function(FetchBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FetchBuilder toBuilder() => new FetchBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Fetch &&
        status == other.status &&
        msg == other.msg &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, status.hashCode), msg.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Fetch')
          ..add('status', status)
          ..add('msg', msg)
          ..add('data', data))
        .toString();
  }
}

class FetchBuilder implements Builder<Fetch, FetchBuilder> {
  _$Fetch _$v;

  int _status;
  int get status => _$this._status;
  set status(int status) => _$this._status = status;

  String _msg;
  String get msg => _$this._msg;
  set msg(String msg) => _$this._msg = msg;

  ListBuilder<Data> _data;
  ListBuilder<Data> get data => _$this._data ??= new ListBuilder<Data>();
  set data(ListBuilder<Data> data) => _$this._data = data;

  FetchBuilder();

  FetchBuilder get _$this {
    if (_$v != null) {
      _status = _$v.status;
      _msg = _$v.msg;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Fetch other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Fetch;
  }

  @override
  void update(void Function(FetchBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Fetch build() {
    _$Fetch _$result;
    try {
      _$result =
          _$v ?? new _$Fetch._(status: status, msg: msg, data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Fetch', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Data extends Data {
  @override
  final String groupId;
  @override
  final String groupName;
  @override
  final String admin;

  factory _$Data([void Function(DataBuilder) updates]) =>
      (new DataBuilder()..update(updates)).build();

  _$Data._({this.groupId, this.groupName, this.admin}) : super._() {
    if (groupId == null) {
      throw new BuiltValueNullFieldError('Data', 'groupId');
    }
    if (groupName == null) {
      throw new BuiltValueNullFieldError('Data', 'groupName');
    }
    if (admin == null) {
      throw new BuiltValueNullFieldError('Data', 'admin');
    }
  }

  @override
  Data rebuild(void Function(DataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DataBuilder toBuilder() => new DataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Data &&
        groupId == other.groupId &&
        groupName == other.groupName &&
        admin == other.admin;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, groupId.hashCode), groupName.hashCode), admin.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Data')
          ..add('groupId', groupId)
          ..add('groupName', groupName)
          ..add('admin', admin))
        .toString();
  }
}

class DataBuilder implements Builder<Data, DataBuilder> {
  _$Data _$v;

  String _groupId;
  String get groupId => _$this._groupId;
  set groupId(String groupId) => _$this._groupId = groupId;

  String _groupName;
  String get groupName => _$this._groupName;
  set groupName(String groupName) => _$this._groupName = groupName;

  String _admin;
  String get admin => _$this._admin;
  set admin(String admin) => _$this._admin = admin;

  DataBuilder();

  DataBuilder get _$this {
    if (_$v != null) {
      _groupId = _$v.groupId;
      _groupName = _$v.groupName;
      _admin = _$v.admin;
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
        new _$Data._(groupId: groupId, groupName: groupName, admin: admin);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
