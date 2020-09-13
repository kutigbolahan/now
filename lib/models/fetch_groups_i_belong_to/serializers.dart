

	import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:built_collection/built_collection.dart';
import 'package:nahere/models/fetch_groups_i_belong_to/fetch_Groups.dart';



part 'serializers.g.dart';

@SerializersFor(const[
  Fetch
])
final Serializers serializers = _$serializers;

Serializers standardSerializers = 
    (serializers.toBuilder()..addPlugin( StandardJsonPlugin())).build();