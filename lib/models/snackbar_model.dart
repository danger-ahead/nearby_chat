import 'package:flutter/widgets.dart';

class SnackBarModel {
  final String title, message;
  final bool? isDismissible;
  final Widget? icon;

  Map<String, dynamic> toJson() => {
        'title': title,
        'message': message,
        'isDismissible': isDismissible,
      };

  SnackBarModel({
    required this.title,
    required this.message,
    this.isDismissible = true,
    this.icon,
  });
}
