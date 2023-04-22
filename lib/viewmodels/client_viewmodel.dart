import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:nearby_chat/enums/view_state.dart';
import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/services/local_storage_service.dart';
import 'package:nearby_chat/ui/components/chat_bubble.dart';
import 'package:nearby_chat/utils/constant.dart';
import 'package:nearby_chat/utils/create_json_string.dart';
import 'package:nearby_chat/utils/log.dart';
import 'package:nearby_chat/viewmodels/base_viewmodel.dart';

class ClientViewModel extends BaseModel {
  late Socket _socket;
  final _log = locator<Log>();
  final _localStorageService = locator<LocalStorageService>();
  late final ScrollController _scrollController;

  final List<Widget> _messages = [];

  List<Widget> get messages => _messages;

  String? get username => _localStorageService.username;
  ScrollController get scrollController => _scrollController;

  Future<void> initSocket(String ipAddress) async {
    try {
      setStateFor(clientConnectionStatus, ViewState.busy);
      _log.info('Connecting to server $ipAddress:$port');
      _socket = await Socket.connect(ipAddress, port);
      _log.info('Connected to server ${_socket.address}');
      setStateFor(clientConnectionStatus, ViewState.success);
    } catch (e) {
      setStateFor(clientConnectionStatus, ViewState.error);
      _log.error(e);
    }

    // Listen for incoming messages
    try {
      _socket.listen((data) {
        _messages.add(
            ChatBubble(data: String.fromCharCodes(data).trim(), isMe: false));
        notifyListeners();
      });
    } catch (e) {
      _log.error(e);
    }

    _scrollController = ScrollController();
  }

  Future<void> sendMessage(String message) async {
    try {
      final temp = createJsonString(username ?? '', message);

      _socket.write(temp);

      _messages.add(ChatBubble(data: temp, isMe: true));

      notifyListeners();

      _log.info('sent message: $temp');
    } catch (e) {
      _log.error(e);
    }
  }

  void disposeSocket() {
    try {
      _socket.destroy();
      _scrollController.dispose();
      _log.info('server closed');
    } catch (e) {
      _log.warning(e);
    }
  }
}
