import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/track.dart';
import 'api.dart';

class StopsSocketApi {
  StopsSocketApi() : _api = WebSocketChannel.connect(Uri.parse(kStopsWsUrl));

  final WebSocketChannel _api;

  Stream<List<Stop>> get stream => _api.stream.map<List<Stop>>((data) {
        final decoded = json.decode(data);
        return (decoded as List).map<Stop>(
          (json) {
            return Stop.fromJson(json);
          },
        ).toList();
      });

  ValueChanged<String> get send => _api.sink.add;
}
