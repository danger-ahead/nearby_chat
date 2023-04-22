import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:nearby_chat/enums/view_state.dart';
import 'package:nearby_chat/locator.dart';
import 'package:nearby_chat/services/dialog_service.dart';
import 'package:nearby_chat/services/local_storage_service.dart';
import 'package:nearby_chat/ui/components/chat_bubble.dart';
import 'package:nearby_chat/utils/constant.dart';
import 'package:nearby_chat/utils/create_json_string.dart';
import 'package:nearby_chat/utils/log.dart';
import 'package:nearby_chat/viewmodels/base_viewmodel.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ServerViewModel extends BaseModel {
  late ServerSocket _server;
  final _networkInfo = locator<NetworkInfo>();
  final _localStorageService = locator<LocalStorageService>();
  final _log = locator<Log>();
  final DialogService _dialogService = locator<DialogService>();
  late final String _serverIpAddress;
  late final ScrollController _scrollController;

  String get serverIpAddress => _serverIpAddress;
  String? get username => _localStorageService.username;
  ScrollController get scrollController => _scrollController;

  final List<Socket> _clients = [];

  final List<Widget> _messages = [];
  List<Widget> get messages => _messages;

  Future<void> initSocket() async {
    setStateFor(initializeSocket, ViewState.busy);
    // Get the IP address of the Wi-Fi access point
    try {
      final ipAddress = await _networkInfo.getWifiIP();
      _serverIpAddress = ipAddress!;
      _server = await ServerSocket.bind(ipAddress, port);
      _log.info('server started at $ipAddress:$port');
      await showServerAddress();
      setStateFor(initializeSocket, ViewState.success);
    } catch (e) {
      _log.error(e);
      setStateFor(initializeSocket, ViewState.error);
    }

    // await for (var socket in _server) {
    //   _handleConnection(socket);
    // }

    try {
      _server.listen((client) {
        _log.info(
            'client connected: ${client.remoteAddress}:${client.remotePort}');

        _clients.add(client);

        client.listen((event) {
          String temp = String.fromCharCodes(event).trim();
          _log.info(
              'received: $temp from ${client.remoteAddress}:${client.remotePort}');

          broadCastToOtherClient(temp, client);

          _messages.add(ChatBubble(data: temp, isMe: false));

          notifyListeners();
        }, onError: (error) {
          _log.error('Error: $error');
          client.destroy();
        }, onDone: () {
          _clients.remove(client);
          client.destroy();
          _log.info('Client disconnected');
        });
      });
    } catch (e) {
      _log.error(e);
    }

    _scrollController = ScrollController();
  }

  void broadCastToOtherClient(String message, Socket senderClient) {
    try {
      for (var client in _clients) {
        /// don't send message to sender
        if (client == senderClient) {
          continue;
        }

        client.write(message);
      }

      _log.info('broadcast message: $message');
    } catch (e) {
      _log.error(e);
    }
  }

  Future<void> sendMessage(String message) async {
    try {
      final temp = createJsonString(username ?? '', message);

      for (var client in _clients) {
        client.write(temp);
      }

      _messages.add(ChatBubble(data: temp, isMe: true));

      notifyListeners();

      _log.info('sent message: $temp');
    } catch (e) {
      _log.error(e);
    }
  }

  void disposeSocket() {
    try {
      _server.close();
      _scrollController.dispose();
      _log.info('server closed');
    } catch (e) {
      _log.error(e);
    }
  }

  Future<void> showServerAddress() async {
    await _dialogService.showDialog(
      title: 'Server Address',
      description: _serverIpAddress,
      buttonTitle: 'Close',
    );
  }

  // Future<void> _handleConnection(Socket socket) async {
  //   _log.info('client connected: ${socket.remoteAddress}:${socket.remotePort}');

  //   socket.writeln('Hello from server!');

  //   socket.listen((data) {
  //     String temp = String.fromCharCodes(data).trim();
  //     _log.info(
  //         'received: $temp from ${socket.remoteAddress}:${socket.remotePort}');
  //     messages.add(ChatBubble(message: temp, isMe: false));
  //     notifyListeners();
  //   }, onError: (error) {
  //     _log.error('Error: $error');
  //     socket.destroy();
  //   }, onDone: () {
  //     _log.info('Client disconnected');
  //     socket.destroy();
  //   });
  // }
}
