import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hello_spec/generated/proto/hello.pb.dart';

void main() {
  test('hello_spec proto <-> json', () {
    var jsonStr =
        '{"id":1,"name":"Chintan Ghate","secretCode":{"secretCode":"hello"}}';
    var parsed = _parseHelloJson(jsonStr);
    var secretCode = StringSecret.create()..secretCode = 'hello';
    var expected = Hello.create()
      ..id = 1
      ..name = 'Chintan Ghate'
      ..stringSecretCode = secretCode;
    expect(parsed, expected);
  });
}

Hello _parseHelloJson(String jsonStr) {
  var hello = Hello()
    ..mergeFromProto3Json(jsonDecode(jsonStr), ignoreUnknownFields: true);
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
