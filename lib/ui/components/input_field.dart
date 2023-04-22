import 'package:flutter/material.dart';
import 'package:nearby_chat/nearbychat_theme.dart';

class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      required this.textController,
      this.actionIcon,
      this.actionWidget,
      this.action,
      required this.hintText,
      this.actionIconColor = NearbyChatTheme.primaryColor})
      : super(key: key);

  final TextEditingController textController;
  final IconData? actionIcon;
  final Color? actionIconColor;
  final Function()? action;
  final String hintText;
  final Widget? actionWidget;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void initState() {
    super.initState();

    /// Make sure that either an icon or a widget is provided
    /// but not both at the same time
    assert(
        ((widget.actionIcon == null &&
                    widget.action == null &&
                    widget.actionWidget != null) ||
                (widget.actionIcon != null &&
                    widget.action != null &&
                    widget.actionWidget == null)) ||
            (widget.actionIcon == null &&
                widget.action == null &&
                widget.actionWidget == null),
        "Either an icon [along with 'action'(onPressed callback function)] or a widget must be provided, but not both at the same time");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            controller: widget.textController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: NearbyChatTheme.primaryColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              hintText: widget.hintText,
            ),
          ),
        ),
        if (widget.actionIcon != null)
          IconButton(
            icon: Icon(
              widget.actionIcon,
              color: widget.actionIconColor,
            ),
            onPressed: widget.action,
          ),
        if (widget.actionWidget != null) widget.actionWidget!
      ],
    );
  }
}
