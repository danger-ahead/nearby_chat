import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearby_chat/models/snackbar_model.dart';
import 'package:nearby_chat/nearbychat_theme.dart';

class SnackBarService {
  void _showSnackbar(SnackBarModel snackBarModel) {
    Get.snackbar(
      snackBarModel.title,
      snackBarModel.message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: NearbyChatTheme.boxBg(Get.context!),
      colorText: Colors.black,
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      isDismissible: snackBarModel.isDismissible,
      icon: snackBarModel.icon,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void showSnackbar(SnackBarModel snackBarModel) {
    _showSnackbar(snackBarModel);
  }
}
