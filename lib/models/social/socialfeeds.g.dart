// GENERATED CODE - DO NOT MODIFY BY HAND

part of social_feeds;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SocialFeeds> _$socialFeedsSerializer = new _$SocialFeedsSerializer();
Serializer<Data> _$dataSerializer = new _$DataSerializer();

class _$SocialFeedsSerializer implements StructuredSerializer<SocialFeeds> {
  @override
  final Iterable<Type> types = const [SocialFeeds, _$SocialFeeds];
  @override
  final String wireName = 'SocialFeeds';

  @override
  Iterable<Object> serialize(Serializers serializers, SocialFeeds object,
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
      'total_rows',
      serializers.serialize(object.totalRows,
          specifiedType: const FullType(int)),
      'num_of_pages',
      serializers.serialize(object.numOfPages,
          specifiedType: const FullType(int)),
      'q',
      serializers.serialize(object.q, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  SocialFeeds deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SocialFeedsBuilder();

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
        case 'total_rows':
          result.totalRows = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'num_of_pages':
          result.numOfPages = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'q':
          result.q = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
      'update_time',
      serializers.serialize(object.updateTime,
          specifiedType: const FullType(String)),
      'firstname',
      serializers.serialize(object.firstname,
          specifiedType: const FullType(String)),
      'lastname',
      serializers.serialize(object.lastname,
          specifiedType: const FullType(String)),
      'profile_pic',
      serializers.serialize(object.profilePic,
          specifiedType: const FullType(String)),
      'profession',
      serializers.serialize(object.profession,
          specifiedType: const FullType(String)),
      'images',
      serializers.serialize(object.images,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'update_time':
          result.updateTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'firstname':
          result.firstname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastname':
          result.lastname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'profile_pic':
          result.profilePic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'profession':
          result.profession = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'images':
          result.images.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$SocialFeeds extends SocialFeeds {
  @override
  final int status;
  @override
  final String msg;
  @override
  final BuiltList<Data> data;
  @override
  final int totalRows;
  @override
  final int numOfPages;
  @override
  final String q;

  factory _$SocialFeeds([void Function(SocialFeedsBuilder) updates]) =>
      (new SocialFeedsBuilder()..update(updates)).build();

  _$SocialFeeds._(
      {this.status,
      this.msg,
      this.data,
      this.totalRows,
      this.numOfPages,
      this.q})
      : super._() {
    if (status == null) {
      throw new BuiltValueNullFieldError('SocialFeeds', 'status');
    }
    if (msg == null) {
      throw new BuiltValueNullFieldError('SocialFeeds', 'msg');
    }
    if (data == null) {
      throw new BuiltValueNullFieldError('SocialFeeds', 'data');
    }
    if (totalRows == null) {
      throw new BuiltValueNullFieldError('SocialFeeds', 'totalRows');
    }
    if (numOfPages == null) {
      throw new BuiltValueNullFieldError('SocialFeeds', 'numOfPages');
    }
    if (q == null) {
      throw new BuiltValueNullFieldError('SocialFeeds', 'q');
    }
  }

  @override
  SocialFeeds rebuild(void Function(SocialFeedsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SocialFeedsBuilder toBuilder() => new SocialFeedsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialFeeds &&
        status == other.status &&
        msg == other.msg &&
        data == other.data &&
        totalRows == other.totalRows &&
        numOfPages == other.numOfPages &&
        q == other.q;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, status.hashCode), msg.hashCode), data.hashCode),
                totalRows.hashCode),
            numOfPages.hashCode),
        q.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SocialFeeds')
          ..add('status', status)
          ..add('msg', msg)
          ..add('data', data)
          ..add('totalRows', totalRows)
          ..add('numOfPages', numOfPages)
          ..add('q', q))
        .toString();
  }
}

class SocialFeedsBuilder implements Builder<SocialFeeds, SocialFeedsBuilder> {
  _$SocialFeeds _$v;

  int _status;
  int get status => _$this._status;
  set status(int status) => _$this._status = status;

  String _msg;
  String get msg => _$this._msg;
  set msg(String msg) => _$this._msg = msg;

  ListBuilder<Data> _data;
  ListBuilder<Data> get data => _$this._data ??= new ListBuilder<Data>();
  set data(ListBuilder<Data> data) => _$this._data = data;

  int _totalRows;
  int get totalRows => _$this._totalRows;
  set totalRows(int totalRows) => _$this._totalRows = totalRows;

  int _numOfPages;
  int get numOfPages => _$this._numOfPages;
  set numOfPages(int numOfPages) => _$this._numOfPages = numOfPages;

  String _q;
  String get q => _$this._q;
  set q(String q) => _$this._q = q;

  SocialFeedsBuilder();

  SocialFeedsBuilder get _$this {
    if (_$v != null) {
      _status = _$v.status;
      _msg = _$v.msg;
      _data = _$v.data?.toBuilder();
      _totalRows = _$v.totalRows;
      _numOfPages = _$v.numOfPages;
      _q = _$v.q;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialFeeds other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SocialFeeds;
  }

  @override
  void update(void Function(SocialFeedsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SocialFeeds build() {
    _$SocialFeeds _$result;
    try {
      _$result = _$v ??
          new _$SocialFeeds._(
              status: status,
              msg: msg,
              data: data.build(),
              totalRows: totalRows,
              numOfPages: numOfPages,
              q: q);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SocialFeeds', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Data extends Data {
  @override
  final String message;
  @override
  final String updateTime;
  @override
  final String firstname;
  @override
  final String lastname;
  @override
  final String profilePic;
  @override
  final String profession;
  @override
  final BuiltList<String> images;

  factory _$Data([void Function(DataBuilder) updates]) =>
      (new DataBuilder()..update(updates)).build();

  _$Data._(
      {this.message,
      this.updateTime,
      this.firstname,
      this.lastname,
      this.profilePic,
      this.profession,
      this.images})
      : super._() {
    if (message == null) {
      throw new BuiltValueNullFieldError('Data', 'message');
    }
    if (updateTime == null) {
      throw new BuiltValueNullFieldError('Data', 'updateTime');
    }
    if (firstname == null) {
      throw new BuiltValueNullFieldError('Data', 'firstname');
    }
    if (lastname == null) {
      throw new BuiltValueNullFieldError('Data', 'lastname');
    }
    if (profilePic == null) {
      throw new BuiltValueNullFieldError('Data', 'profilePic');
    }
    if (profession == null) {
      throw new BuiltValueNullFieldError('Data', 'profession');
    }
    if (images == null) {
      throw new BuiltValueNullFieldError('Data', 'images');
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
        message == other.message &&
        updateTime == other.updateTime &&
        firstname == other.firstname &&
        lastname == other.lastname &&
        profilePic == other.profilePic &&
        profession == other.profession &&
        images == other.images;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, message.hashCode), updateTime.hashCode),
                        firstname.hashCode),
                    lastname.hashCode),
                profilePic.hashCode),
            profession.hashCode),
        images.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Data')
          ..add('message', message)
          ..add('updateTime', updateTime)
          ..add('firstname', firstname)
          ..add('lastname', lastname)
          ..add('profilePic', profilePic)
          ..add('profession', profession)
          ..add('images', images))
        .toString();
  }
}

class DataBuilder implements Builder<Data, DataBuilder> {
  _$Data _$v;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _updateTime;
  String get updateTime => _$this._updateTime;
  set updateTime(String updateTime) => _$this._updateTime = updateTime;

  String _firstname;
  String get firstname => _$this._firstname;
  set firstname(String firstname) => _$this._firstname = firstname;

  String _lastname;
  String get lastname => _$this._lastname;
  set lastname(String lastname) => _$this._lastname = lastname;

  String _profilePic;
  String get profilePic => _$this._profilePic;
  set profilePic(String profilePic) => _$this._profilePic = profilePic;

  String _profession;
  String get profession => _$this._profession;
  set profession(String profession) => _$this._profession = profession;

  ListBuilder<String> _images;
  ListBuilder<String> get images =>
      _$this._images ??= new ListBuilder<String>();
  set images(ListBuilder<String> images) => _$this._images = images;

  DataBuilder();

  DataBuilder get _$this {
    if (_$v != null) {
      _message = _$v.message;
      _updateTime = _$v.updateTime;
      _firstname = _$v.firstname;
      _lastname = _$v.lastname;
      _profilePic = _$v.profilePic;
      _profession = _$v.profession;
      _images = _$v.images?.toBuilder();
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
    _$Data _$result;
    try {
      _$result = _$v ??
          new _$Data._(
              message: message,
              updateTime: updateTime,
              firstname: firstname,
              lastname: lastname,
              profilePic: profilePic,
              profession: profession,
              images: images.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        images.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Data', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
