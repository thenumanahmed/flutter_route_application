import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/users.dart';
import './api.dart';

class DriversSocketApi {
  DriversSocketApi()
      : _api = WebSocketChannel.connect(Uri.parse(SocketApi.kDriversWsUrl));

  final WebSocketChannel _api;

  Stream<List<User>> get stream => _api.stream.map<List<User>>((data) {
        final decoded = json.decode(data);
        return (decoded as List).map<User>(
          (json) {
            return User.fromJson(json);
          },
        ).toList();
      });

  ValueChanged<String> get send => _api.sink.add;
}
