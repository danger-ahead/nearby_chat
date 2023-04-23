import 'dart:convert';
import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/services/log_service.dart';
import 'package:nearby_chat/viewmodels/base_viewmodel.dart';

class ChatBubbleViewModel extends BaseModel {
  final _log = locator<Log>();

  Map<String, dynamic> decodeJsonString(String jsonString) {
    _log.info('decoding message: $jsonString');
    return jsonDecode(jsonString);
  }
}
