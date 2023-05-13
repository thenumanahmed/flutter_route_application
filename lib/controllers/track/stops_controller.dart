import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../models/track.dart';
import '../../sockets/stops_api.dart';
import '../fetching.dart';
import './tracks_controller.dart';

class StopsController extends GetxController {
  final fetching = FetchingState.getting.obs;
  final stops = <Stop>[].obs;

  final _socketStream = StreamController<List<Stop>>.broadcast();
  final api = StopsSocketApi();

  @override
  void onInit() {
    super.onInit();
    _loadStops();
  }

  void _loadStops() {
    api.stream.listen((data) {
      fetching.value = FetchingState.getting;
      stops.clear();
      stops.addAll(data);
      fetching.value = FetchingState.done;
      Get.find<TracksController>().signalStopsUpdate();
      // add the data to the _socketStream for other listeners
      _socketStream.add(data);
    });
    api.send(json.encode({'action': 'LOAD'}));
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

  void addStop(Stop s) {}

  void deleteStop(mongo.ObjectId id) {}

  void updateStop(Stop s) {}
}
