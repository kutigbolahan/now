// GENERATED CODE - DO NOT MODIFY BY HAND

part of user_profile;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserProfile> _$userProfileSerializer = new _$UserProfileSerializer();
Serializer<Data> _$dataSerializer = new _$DataSerializer();

class _$UserProfileSerializer implements StructuredSerializer<UserProfile> {
  @override
  final Iterable<Type> types = const [UserProfile, _$UserProfile];
  @override
  final String wireName = 'UserProfile';

  @override
  Iterable<Object> serialize(Serializers serializers, UserProfile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data, specifiedType: const FullType(Data)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(String)),
      'msg',
      serializers.serialize(object.msg, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  UserProfile deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(Data)) as Data);
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'msg':
          result.msg = serializers.deserialize(value,
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
      'firstname',
      serializers.serialize(object.firstname,
          specifiedType: const FullType(String)),
      'lastname',
      serializers.serialize(object.lastname,
          specifiedType: const FullType(String)),
      'othernames',
      serializers.serialize(object.othernames,
          specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'phone',
      serializers.serialize(object.phone,
          specifiedType: const FullType(String)),
      'gender',
      serializers.serialize(object.gender,
          specifiedType: const FullType(String)),
      'dob',
      serializers.serialize(object.dob, specifiedType: const FullType(String)),
      'pics',
      serializers.serialize(object.pics, specifiedType: const FullType(String)),
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
        case 'firstname':
          result.firstname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastname':
          result.lastname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'othernames':
          result.othernames = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'gender':
          result.gender = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'dob':
          result.dob = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pics':
          result.pics = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$UserProfile extends UserProfile {
  @override
  final Data data;
  @override
  final String status;
  @override
  final String msg;

  factory _$UserProfile([void Function(UserProfileBuilder) updates]) =>
      (new UserProfileBuilder()..update(updates)).build();

  _$UserProfile._({this.data, this.status, this.msg}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'data');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'status');
    }
    if (msg == null) {
      throw new BuiltValueNullFieldError('UserProfile', 'msg');
    }
  }

  @override
  UserProfile rebuild(void Function(UserProfileBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserProfileBuilder toBuilder() => new UserProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfile &&
        data == other.data &&
        status == other.status &&
        msg == other.msg;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, data.hashCode), status.hashCode), msg.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserProfile')
          ..add('data', data)
          ..add('status', status)
          ..add('msg', msg))
        .toString();
  }
}

class UserProfileBuilder implements Builder<UserProfile, UserProfileBuilder> {
  _$UserProfile _$v;

  DataBuilder _data;
  DataBuilder get data => _$this._data ??= new DataBuilder();
  set data(DataBuilder data) => _$this._data = data;

  String _status;
  String get status => _$this._status;
  set status(String status) => _$this._status = status;

  String _msg;
  String get msg => _$this._msg;
  set msg(String msg) => _$this._msg = msg;

  UserProfileBuilder();

  UserProfileBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _status = _$v.status;
      _msg = _$v.msg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserProfile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserProfile;
  }

  @override
  void update(void Function(UserProfileBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserProfile build() {
    _$UserProfile _$result;
    try {
      _$result = _$v ??
          new _$UserProfile._(data: data.build(), status: status, msg: msg);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'UserProfile', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Data extends Data {
  @override
  final String firstname;
  @override
  final String lastname;
  @override
  final String othernames;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String gender;
  @override
  final String dob;
  @override
  final String pics;

  factory _$Data([void Function(DataBuilder) updates]) =>
      (new DataBuilder()..update(updates)).build();

  _$Data._(
      {this.firstname,
      this.lastname,
      this.othernames,
      this.email,
      this.phone,
      this.gender,
      this.dob,
      this.pics})
      : super._() {
    if (firstname == null) {
      throw new BuiltValueNullFieldError('Data', 'firstname');
    }
    if (lastname == null) {
      throw new BuiltValueNullFieldError('Data', 'lastname');
    }
    if (othernames == null) {
      throw new BuiltValueNullFieldError('Data', 'othernames');
    }
    if (email == null) {
      throw new BuiltValueNullFieldError('Data', 'email');
    }
    if (phone == null) {
      throw new BuiltValueNullFieldError('Data', 'phone');
    }
    if (gender == null) {
      throw new BuiltValueNullFieldError('Data', 'gender');
    }
    if (dob == null) {
      throw new BuiltValueNullFieldError('Data', 'dob');
    }
    if (pics == null) {
      throw new BuiltValueNullFieldError('Data', 'pics');
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
        firstname == other.firstname &&
        lastname == other.lastname &&
        othernames == other.othernames &&
        email == other.email &&
        phone == other.phone &&
        gender == other.gender &&
        dob == other.dob &&
        pics == other.pics;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, firstname.hashCode), lastname.hashCode),
                            othernames.hashCode),
                        email.hashCode),
                    phone.hashCode),
                gender.hashCode),
            dob.hashCode),
        pics.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Data')
          ..add('firstname', firstname)
          ..add('lastname', lastname)
          ..add('othernames', othernames)
          ..add('email', email)
          ..add('phone', phone)
          ..add('gender', gender)
          ..add('dob', dob)
          ..add('pics', pics))
        .toString();
  }
}

class DataBuilder implements Builder<Data, DataBuilder> {
  _$Data _$v;

  String _firstname;
  String get firstname => _$this._firstname;
  set firstname(String firstname) => _$this._firstname = firstname;

  String _lastname;
  String get lastname => _$this._lastname;
  set lastname(String lastname) => _$this._lastname = lastname;

  String _othernames;
  String get othernames => _$this._othernames;
  set othernames(String othernames) => _$this._othernames = othernames;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _phone;
  String get phone => _$this._phone;
  set phone(String phone) => _$this._phone = phone;

  String _gender;
  String get gender => _$this._gender;
  set gender(String gender) => _$this._gender = gender;

  String _dob;
  String get dob => _$this._dob;
  set dob(String dob) => _$this._dob = dob;

  String _pics;
  String get pics => _$this._pics;
  set pics(String pics) => _$this._pics = pics;

  DataBuilder();

  DataBuilder get _$this {
    if (_$v != null) {
      _firstname = _$v.firstname;
      _lastname = _$v.lastname;
      _othernames = _$v.othernames;
      _email = _$v.email;
      _phone = _$v.phone;
      _gender = _$v.gender;
      _dob = _$v.dob;
      _pics = _$v.pics;
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
            firstname: firstname,
            lastname: lastname,
            othernames: othernames,
            email: email,
            phone: phone,
            gender: gender,
            dob: dob,
            pics: pics);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
