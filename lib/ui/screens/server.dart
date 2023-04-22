import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nearby_chat/ui/base_view.dart';
import 'package:nearby_chat/ui/components/input_field.dart';
import 'package:nearby_chat/utils/constant.dart';
import 'package:nearby_chat/viewmodels/server_viewmodel.dart';

class Server extends StatefulWidget {
  const Server({Key? key}) : super(key: key);

  @override
  State<Server> createState() => _ServerState();
}

class _ServerState extends State<Server> {
  late final TextEditingController _messageController;
  late Socket socket;

  late ServerViewModel _model;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      _model.sendMessage(message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ServerViewModel>(
        onModelReady: (model) => {
              _model = model,
              _model.initSocket(),
            },
        onModelDestroy: (model) => {_model.disposeSocket()},
        builder: (context, model, child) {
          if (_model.messages.isNotEmpty) {
            _model.scrollController.animateTo(
                _model.scrollController.position.maxScrollExtent + 70,
                duration: const Duration(milliseconds: 100),
                curve: Curves.linear);
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Chat'),
              actions: [
                IconButton(
                    icon: const Icon(Icons.info),
                    onPressed: () => {_model.showServerAddress()}),
              ],
            ),
            body: _model.isBusy(initializeSocket)
                ? const Center(child: CircularProgressIndicator())
                : _model.isSuccess(initializeSocket)
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: _model.scrollController,
                              itemCount: _model.messages.length,
                              itemBuilder: (context, index) {
                                return _model.messages[index];
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InputField(
                              textController: _messageController,
                              actionIcon: Icons.send,
                              action: _sendMessage,
                              hintText: 'Message',
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text('Error'),
                      ),
          );
        });
  }
}
