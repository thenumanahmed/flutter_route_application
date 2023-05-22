import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/route.dart' as r;
import 'api.dart';

class RoutesSocketApi {
  RoutesSocketApi()
      : _api = WebSocketChannel.connect(Uri.parse(SocketApi.kRoutesWsUrl));

  final WebSocketChannel _api;

  Stream<List<r.Route>> get stream => _api.stream.map<List<r.Route>>((data) {
        final decoded = json.decode(data);
        return (decoded as List).map<r.Route>(
          (json) {
            return r.Route.fromJson(json);
          },
        ).toList();
      });

  ValueChanged<String> get send => _api.sink.add;
}
