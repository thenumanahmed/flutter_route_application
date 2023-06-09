import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/track.dart';
import 'api.dart';

class TracksSocketApi {
  TracksSocketApi()
      : _api = WebSocketChannel.connect(Uri.parse(SocketApi.kTracksWsUrl));

  final WebSocketChannel _api;

  Stream<List<Track>> get stream => _api.stream.map<List<Track>>((data) {
        final decoded = json.decode(data);
        return (decoded as List).map<Track>(
          (json) {
            return Track.fromJson(json);
          },
        ).toList();
      });

  ValueChanged<String> get send => _api.sink.add;
}
