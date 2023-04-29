import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/services/log_service.dart';
import 'package:nearby_chat/utils/parse_json_string.dart';
import 'package:nearby_chat/viewmodels/base_viewmodel.dart';

class ChatBubbleViewModel extends BaseModel {
  final _log = locator<Log>();

  Map<String, dynamic> decodeJsonString(String jsonString) {
    final Map<String, dynamic> result = parseJsonString(jsonString);

    try {
      _log.info('decoding message: $jsonString');
      return result;
    } catch (e) {
      _log.error('error decoding message: $jsonString');
      return {
        'username': 'error',
        'message': 'error decoding message',
      };
    }
  }
}
