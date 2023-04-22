import 'package:flutter/material.dart';
import 'package:nearby_chat/nearbychat_theme.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton(
      {super.key, required this.buttonTitle, required this.onPressed});

  final String buttonTitle;
  final Function() onPressed;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              NearbyChatTheme.primaryColorDark,
            ),
          ),
          onPressed: widget.onPressed,
          child: Text(widget.buttonTitle)),
    );
  }
}
