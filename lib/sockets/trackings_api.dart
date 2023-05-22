import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/tracking.dart';
import 'api.dart';

class TrackingsSocketApi {
  TrackingsSocketApi()
      : _api = WebSocketChannel.connect(Uri.parse(SocketApi.kTrackingsWsUrl));

  final WebSocketChannel _api;

  Stream<List<Tracking>> get stream => _api.stream.map<List<Tracking>>((data) {
        final decoded = json.decode(data);
        return (decoded as List).map<Tracking>(
          (json) {
            return Tracking.fromJson(json);
          },
        ).toList();
      });

  ValueChanged<String> get send => _api.sink.add;
}
