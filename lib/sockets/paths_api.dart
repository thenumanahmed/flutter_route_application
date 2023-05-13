import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/path.dart';
import 'api.dart';

class PathsSocketApi {
  PathsSocketApi() : _api = WebSocketChannel.connect(Uri.parse(kPathsWsUrl));

  final WebSocketChannel _api;

  Stream<List<Path>> get stream => _api.stream.map<List<Path>>((data) {
        final decoded = json.decode(data);
        return (decoded as List).map<Path>(
          (json) {
            return Path.fromJson(json);
          },
        ).toList();
      });

  ValueChanged<String> get send => _api.sink.add;
}
