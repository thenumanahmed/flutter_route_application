import 'dart:async';
import 'dart:convert';

import 'package:dashboard_route_app/controllers/track/edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../models/track.dart';
import '../../sockets/stops_api.dart';
import '../fetching.dart';
import './tracks_controller.dart';

class StopsController extends GetxController {
  final fetching = FetchingState.getting.obs;
  final stops = <Stop>[].obs;
  final valueUpadte = false.obs;

  final _socketStream = StreamController<List<Stop>>.broadcast();
  final api = StopsSocketApi();

  doUpdate() {
    valueUpadte.value = !valueUpadte.value;
  }

  @override
  void onInit() {
    super.onInit();
    _loadStops();
  }

  void _loadStops() {
    api.stream.listen((data) {
      fetching.value = FetchingState.getting;
      TracksController.loading.value = true;
      EditController.selectedIndexes.value = [];
      EditController.editBodyState.value = EditBodyState.map;
      stops.clear();
      stops.addAll(data);
      TracksController.loading.value = false;
      doUpdate();
      Get.find<TracksController>().signalStopsUpdate();
      // add the data to the _socketStream for other listeners

      _socketStream.add(data);
    });
    api.send(json.encode({'action': 'LOAD'}));
  }

  void addStop(mongo.ObjectId trackId, String name, TimeOfDay time, int stopNo,
      double latitude, double longitude,
      {bool isStop = true}) {
    final s = Stop(
      id: mongo.ObjectId(),
      trackId: trackId,
      name: name,
      time: time,
      isStop: true,
      stopNo: stopNo,
      latitude: latitude,
      longitude: longitude,
    );

    api.send(json.encode({
      'action': 'ADD',
      'payload': s.toJson(),
    }));
  }

  void updateStop(Stop s) {
    api.send(json.encode({
      'action': 'UPDATE',
      'payload': s.toJson(),
    }));
  }

  void deleteStops(List<mongo.ObjectId> stopsId) {
    api.send(json.encode({
      'action': 'DELETE_MULTIPLE',
      'payload': stopsId.toList(),
    }));
  }

  List<Stop> getStopByTrackID(mongo.ObjectId id) {
    List<Stop> dStop = [];
    for (int i = 0; i < stops.length; i++) {
      if (stops[i].trackId == id) {
        dStop.add(stops[i]);
      }
    }
    return dStop;
  }

  List<int> searchByStops(List<Stop> sStops, String s) {
    List<int> list = [];
    for (int i = 0; i < sStops.length; i++) {
      if (sStops[i].name.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }
}
