import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hello_spec/generated/proto/hello.pb.dart';
import 'package:protobuf/src/protobuf/type_registry.dart';
import 'package:hello_spec/generated/google/protobuf/any.pb.dart';

void main() {
  test('hello_spec proto <-> json', () {
    var jsonStr =
        '{"id":1,"name":"Chintan Ghate","secretCode":{"secretCode":"hello","@type":"type.googleapis.com/hello_spec.StringSecret"}}';
    var parsed = Hello()
      ..mergeFromProto3Json(jsonDecode(jsonStr),
          typeRegistry:
              TypeRegistry([StringSecret(), DoubleSecret(), IntSecret()]),
          ignoreUnknownFields: true);
    var expected = Hello.create()
      ..id = 1
      ..name = 'Chintan Ghate'
      ..secretCode = Any.pack(StringSecret.create()..secretCode = 'hello');
    expect(parsed, expected);
    expect(
        jsonStr,
        jsonEncode(expected.toProto3Json(
            typeRegistry:
                TypeRegistry([StringSecret(), DoubleSecret(), IntSecret()]))));
  });
}
