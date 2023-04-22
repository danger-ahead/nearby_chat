import 'package:logger/logger.dart';

class Log {
  factory Log() {
    _singleton ??= Log._();
    return _singleton!;
  }

  Log._();

  static Log? _singleton;

  final logger = Logger();

  void info(dynamic message) {
    logger.i(message);
  }

  void error(dynamic message) {
    logger.e(message);
  }

  void warning(dynamic message) {
    logger.w(message);
  }
}
