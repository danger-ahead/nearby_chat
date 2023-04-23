import 'package:flutter/material.dart';

class DialogRequest {
  DialogRequest({
    required this.title,
    this.description,
    this.buttonTitle,
    this.cancelTitle,
    this.isDismissible = true,
    this.keyboardType = TextInputType.text,
  });

  final String title;
  final String? description;
  final String? buttonTitle;
  final String? cancelTitle;

  final bool? isDismissible;
  final TextInputType? keyboardType;
}

class DialogResponse {
  DialogResponse({
    required this.confirmed,
    this.value,
  });

  final bool confirmed;
  final String? value;
}
