import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/bus.dart';
import 'api.dart';

class BusesSocketApi {
  BusesSocketApi()
      : _api = WebSocketChannel.connect(Uri.parse(SocketApi.kBusesWsUrl));

  final WebSocketChannel _api;

  Stream<List<Bus>> get stream => _api.stream.map<List<Bus>>((data) {
        final decoded = json.decode(data);
        return (decoded as List).map<Bus>(
          (json) {
            return Bus.fromJson(json);
          },
        ).toList();
      });

  ValueChanged<String> get send => _api.sink.add;
}
