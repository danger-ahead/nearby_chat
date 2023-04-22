import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/services/local_storage_service.dart';
import 'package:nearby_chat/utils/log.dart';
import 'package:nearby_chat/viewmodels/base_viewmodel.dart';

class MainViewModel extends BaseModel {
  final _log = locator<Log>();
  final _localStorageService = locator<LocalStorageService>();
  String? _theme;

  String? get theme => _theme;

  void initState() {
    _localStorageService.getTheme();
    _log.info('theme: ${_localStorageService.themeNotifier.value}');
    _localStorageService.themeNotifier.addListener(() {
      _theme = _localStorageService.themeNotifier.value;
      notifyListeners();
    });
  }
}
