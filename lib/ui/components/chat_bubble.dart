import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:nearby_chat/nearbychat_theme.dart';
import 'package:nearby_chat/ui/base_view.dart';
import 'package:nearby_chat/viewmodels/chat_bubble_viewmodel.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({Key? key, required this.data, this.isMe = false})
      : super(key: key);

  final String data;
  final bool? isMe;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  late final ChatBubbleViewModel _model;
  late String _username, _message;

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatBubbleViewModel>(
        onModelReady: (model) {
          _model = model;
          final temp = _model.decodeJsonString(widget.data);
          _username = temp['username']!;
          _message = temp['message']!;
        },
        builder: ((context, model, child) => Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                crossAxisAlignment: widget.isMe!
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 2.0,
                        right: widget.isMe! ? 16 : 0,
                        left: widget.isMe! ? 0 : 16),
                    child: Text(
                      _username,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            NearbyChatTheme.textColor(context).withOpacity(0.7),
                      ),
                    ),
                  ),
                  BubbleSpecialOne(
                    text: _message,
                    isSender: widget.isMe!,
                    color: NearbyChatTheme.primaryColor.withOpacity(0.4),
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: NearbyChatTheme.textColor(context),
                    ),
                  ),
                ],
              ),
            )));
  }
}
