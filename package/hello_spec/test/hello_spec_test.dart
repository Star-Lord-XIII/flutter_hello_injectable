import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hello_spec/generated/proto/hello.pb.dart';

void main() {
  test('hello_spec proto <-> json', () {
    var jsonStr =
        '{"id":1,"name":"Chintan Ghate","secretCode":{"secretCode":"hello"}}';
    var parsed = Hello()
      ..mergeFromProto3Json(jsonDecode(jsonStr), ignoreUnknownFields: true);
    var expected = Hello.create()
      ..id = 1
      ..name = 'Chintan Ghate';
    expect(parsed, expected);
    var extractedSecretCode = _extractSecretCode(jsonStr);
    if (extractedSecretCode is DoubleSecret) {
      expect(_extractSecretCode(jsonStr),
          DoubleSecret.create()..secretCode = 123.25);
    } else if (extractedSecretCode is IntSecret) {
      expect(_extractSecretCode(jsonStr), IntSecret.create()..secretCode = 123);
    } else if (extractedSecretCode is StringSecret) {
      expect(_extractSecretCode(jsonStr),
          StringSecret.create()..secretCode = 'hello');
    }
  });
}

dynamic _extractSecretCode(String jsonStr) {
  var key = 'secretCode';
  var jsonToMap = jsonDecode(jsonStr) as Map<String, dynamic>;
  var secretCodeMap = jsonToMap[key];
  if (secretCodeMap[key] is String) {
    return StringSecret()..mergeFromProto3Json(secretCodeMap);
  } else if (secretCodeMap[key] is double) {
    return DoubleSecret()..mergeFromProto3Json(secretCodeMap);
  }
  return IntSecret()..mergeFromProto3Json(secretCodeMap);
}
