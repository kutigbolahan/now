

	import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';


import 'package:nahere/models/userprofile/userprofilemodel.dart';



part 'serializers.g.dart';

@SerializersFor(const[
  UserProfile
])
final Serializers serializers = _$serializers;

Serializers standardSerializers = 
    (serializers.toBuilder()..addPlugin( StandardJsonPlugin())).build();