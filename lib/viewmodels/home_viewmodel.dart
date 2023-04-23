import 'package:flutter/material.dart';
import 'package:nearby_chat/enums/view_state.dart';
import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/services/dialog_service.dart';
import 'package:nearby_chat/services/local_storage_service.dart';
import 'package:nearby_chat/utils/constant.dart';
import 'package:nearby_chat/viewmodels/base_viewmodel.dart';

class HomeViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final _localStorageService = locator<LocalStorageService>();

  Future<void> getUsername() async {
    final String? username = _localStorageService.username;

    if (username == null) {
      var dialogResponse = await _dialogService.showInputDialog(
        title: 'Username',
        description: 'Enter your username',
        confirmationTitle: 'Continue',
        isDismissible: false,
      );

      if (dialogResponse?.confirmed == true) {
        if (dialogResponse != null &&
            dialogResponse.value != null &&
            dialogResponse.value!.isNotEmpty) {
          _localStorageService.username = dialogResponse.value;
        } else {
          _localStorageService.username = 'Anonymous';
        }
      } else {
        _localStorageService.username = 'Anonymous';
      }
    }
  }

  Future<String?> getServerAddress() async {
    setStateFor(ipAddressInput, ViewState.busy);
    var dialogResponse = await _dialogService.showInputDialog(
        title: 'Server Address',
        description: 'Enter the server address',
        confirmationTitle: 'Continue',
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
          signed: false,
        ));

    if (dialogResponse?.confirmed == true) {
      if (dialogResponse != null &&
          dialogResponse.value != null &&
          dialogResponse.value!.isNotEmpty) {
        setStateFor(ipAddressInput, ViewState.success);
        if (dialogResponse.value == '') {
          return null;
        }
        return dialogResponse.value;
      } else {
        setStateFor(ipAddressInput, ViewState.error);
      }
    } else {
      setStateFor(ipAddressInput, ViewState.idle);
    }
    return null;
  }
}
