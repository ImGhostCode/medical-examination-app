import 'dart:convert';

String paramToBase64(Map<String, dynamic> params) {
  String jsonStr = jsonEncode(params);
  String base64Str = base64Encode(utf8.encode(jsonStr));
  print(base64Str);
  return base64Str;
}
