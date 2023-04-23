import 'package:flutter/material.dart';
import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/models/snackbar_model.dart';
import 'package:nearby_chat/services/local_storage_service.dart';
import 'package:nearby_chat/services/snackbar_service.dart';
import 'package:nearby_chat/services/log_service.dart';
import 'package:nearby_chat/viewmodels/base_viewmodel.dart';

class SettingsViewModel extends BaseModel {
  final _localStorageService = locator<LocalStorageService>();
  final _snackBarService = locator<SnackBarService>();
  final _log = locator<Log>();

  void setUsername(String name) {
    _localStorageService.username = name;
    _snackBarService.showSnackbar(SnackBarModel(
        title: 'Success!',
        message: 'Username updated to $name.',
        icon: const Icon(Icons.info)));
    _log.info('username updated to "$name"');
  }

  void setTheme(String theme) {
    _localStorageService.theme = theme;
    _log.info('theme updated to "$theme"');
    notifyListeners();
  }

  String? get username => _localStorageService.username;
  String? get theme => _localStorageService.themeNotifier.value;
}
