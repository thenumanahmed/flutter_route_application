import 'dart:convert';

import 'package:dashboard_route_app/controllers/routes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../models/tracking.dart';

enum TrackingState { map, single, multiple }

class TrackingController extends GetxController {
  final trackingState = TrackingState.map.obs;
  final indexes = <int>[].obs;
  final trackings = <Tracking>[].obs;
  // final

  //TODO: mongo getTrackings()
  //TODO: mongo stopTracking(mongo.ObjectId trackingId)

  @override
  void onReady() {
    // initAuth();
    super.onReady();
    initializeValues();
  }

  void copyTrackingToClipboard() {
    final jsonList = trackings.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString))
        .then((v) => print('data Copied'));
  }

  void stopTracking(List<int> index) {
    index.sort();
    for (int i = index.length - 1; i >= 0; i--) {
      // TODO: mongo stopTracking(monog.ObjectId trackingId)
      // if success delete then execute trackings.removeAt(index[i]);
      trackings.removeAt(index[i]);
    }
    indexes.clear();
    trackingState.value = TrackingState.map;
  }

  void initializeValues() {
    //TODO: mongodatebase getTracking()
    // kia ab har jagah batah diya ha idher nahi batah raha

    localInitialize();
  }

  void localInitialize() {
    final rc = Get.find<RouteController>();

    final tTracking = [
      Tracking(
        id: mongo.ObjectId(),
        routeId: rc.morning[0].id,
        latitude: rc.morning[0].track!.stops[3].latitude,
        longitude: rc.morning[0].track!.stops[3].longitude,
        stopCovered: 3,
        updateTime: const TimeOfDay(hour: 7, minute: 35),
      ),
      Tracking(
        id: mongo.ObjectId(),
        routeId: rc.morning[1].id,
        latitude: rc.morning[1].track!.stops[4].latitude,
        longitude: rc.morning[1].track!.stops[4].longitude,
        stopCovered: 4,
        updateTime: const TimeOfDay(hour: 7, minute: 35),
      ),
      Tracking(
        id: mongo.ObjectId(),
        routeId: rc.morning[2].id,
        latitude: rc.morning[2].track!.stops[4].latitude,
        longitude: rc.morning[2].track!.stops[4].longitude,
        stopCovered: 4,
        updateTime: const TimeOfDay(hour: 7, minute: 35),
      ),
      Tracking(
        id: mongo.ObjectId(),
        routeId: rc.morning[3].id,
        latitude: rc.morning[3].track!.stops[5].latitude,
        longitude: rc.morning[3].track!.stops[5].longitude,
        stopCovered: 5,
        updateTime: const TimeOfDay(hour: 7, minute: 35),
      )
    ];

    trackings.value = tTracking;
  }

  void setIndexes(List<int> index) {
    indexes.value = index;
    if (index.isEmpty) {
      trackingState.value = TrackingState.map;
    } else if (index.length == 1) {
      trackingState.value = TrackingState.single;
    } else {
      trackingState.value = TrackingState.multiple;
    }
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    for (int i = 0; i < trackings.length; i++) {
      if (trackings[i].name.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }
}
