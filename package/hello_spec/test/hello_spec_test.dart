import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hello_spec/generated/proto/hello.pb.dart';

void main() {
  test('hello_spec proto <-> json', () {
    var jsonStr = '{"id":1,"name""Chintan Ghate"}';
    var parsed = Hello()..mergeFromProto3Json(jsonDecode(jsonStr));
    var expected = Hello.create()
      ..id = 1
      ..name = 'Chintan Ghate';
    expect(parsed, expected);
    expect(jsonStr, jsonEncode(expected.toProto3Json()));
  });
}
