import 'package:nearby_chat/enums/view_state.dart';
import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/services/dialog_service.dart';
import 'package:nearby_chat/utils/constant.dart';
import 'package:nearby_chat/viewmodels/base_viewmodel.dart';

class HomeViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();

  Future<String?> getServerAddress() async {
    setStateFor(ipAddressInput, ViewState.busy);
    var dialogResponse = await _dialogService.showInputDialog(
      title: 'Server Address',
      description: 'Enter the server address',
      confirmationTitle: 'Continue',
    );

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
