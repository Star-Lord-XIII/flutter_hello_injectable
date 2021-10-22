import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hello_spec/generated/proto/hello.pb.dart';
import 'package:hello_spec/extension/proto_json.dart';

void main() {
  test('hello_spec proto <-> json', () {
    var jsonStr =
        '{"id":1,"name":"Chintan Ghate","secretCode":{"secretCode":123.23}}';
    var parsed = _parseHelloJson(jsonStr);
    var secretCode = DoubleSecret.create()..secretCode = 123.23;
    var expected = Hello.create()
      ..id = 1
      ..name = 'Chintan Ghate'
      ..doubleSecretCode = secretCode;
    expect(parsed, expected);
  });
}

Hello _parseHelloJson(String jsonStr) {
  var hello = Hello()..fromJson(jsonStr);
  var key = 'secretCode';
  var jsonToMap = jsonDecode(jsonStr) as Map<String, dynamic>;
  var secretCodeMap = jsonToMap[key];
  if (secretCodeMap[key] is String) {
    var secret = StringSecret()..mergeFromProto3Json(secretCodeMap);
    return hello
      ..toBuilder()
      ..stringSecretCode = secret;
  } else if (secretCodeMap[key] is double) {
    var secret = DoubleSecret()..mergeFromProto3Json(secretCodeMap);
    return hello
      ..toBuilder()
      ..doubleSecretCode = secret;
  }
  var secret = IntSecret()..mergeFromProto3Json(secretCodeMap);
  return hello
    ..toBuilder()
    ..intSecretCode = secret;
}
