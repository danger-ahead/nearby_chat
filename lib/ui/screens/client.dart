import 'package:flutter/material.dart';
import 'package:nearby_chat/ui/base_view.dart';
import 'package:nearby_chat/ui/components/input_field.dart';
import 'package:nearby_chat/utils/constant.dart';
import 'package:nearby_chat/viewmodels/client_viewmodel.dart';

class Client extends StatefulWidget {
  const Client({Key? key, required this.ipAddress}) : super(key: key);

  /// the ip address of the server
  /// to be used to connect to the server
  final String ipAddress;

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  late ClientViewModel _model;

  late final TextEditingController _messageController;

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: BaseView<ClientViewModel>(
            onModelReady: (model) => {
                  _model = model,
                  _model.initSocket(widget.ipAddress),
                },
            onModelDestroy: (model) => {_model.disposeSocket()},
            builder: (context, model, child) {
              if (_model.messages.isNotEmpty) {
                _model.scrollController.animateTo(
                    _model.scrollController.position.maxScrollExtent + 70,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.linear);
              }

              return _model.isBusy(clientConnectionStatus)
                  ? const Center(child: CircularProgressIndicator())
                  : _model.isError(clientConnectionStatus)
                      ? const Center(
                          child: Text(
                            'Error connecting to server',
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ScrollConfiguration(
                                behavior: const ScrollBehavior()
                                    .copyWith(overscroll: false),
                                child: ListView.builder(
                                  itemCount: _model.messages.length,
                                  controller: _model.scrollController,
                                  itemBuilder: (context, index) {
                                    return _model.messages[index];
                                  },
                                ),
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
                        );
            }));
  }
}
