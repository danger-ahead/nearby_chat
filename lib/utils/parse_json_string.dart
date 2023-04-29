import 'dart:convert';

Map<String, dynamic> parseJsonString(String jsonString) {
  try {
    return jsonDecode(jsonString);
  } catch (e) {
    throw Exception(e);
  }
}
