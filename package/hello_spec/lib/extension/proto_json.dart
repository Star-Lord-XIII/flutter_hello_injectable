import 'dart:convert';

import 'package:protobuf/protobuf.dart';

extension ProtoJson on GeneratedMessage {
  void fromJson(String json) {
    mergeFromProto3Json(jsonDecode(json), ignoreUnknownFields: true);
  }
}
