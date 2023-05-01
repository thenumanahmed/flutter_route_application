import 'package:dashboard_route_app/controllers/routes_controller.dart';
import 'package:dashboard_route_app/models/track.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../models/route.dart' as r;

import '../controllers/track/tracks_controller.dart';
import '../functions/time.dart';

class Tracking {
  mongo.ObjectId id;
  mongo.ObjectId routeId;
  double latitude;
  double longitude;
  int stopCovered;
  TimeOfDay updateTime;
  Tracking({
    required this.id,
    required this.routeId,
    required this.latitude,
    required this.longitude,
    required this.stopCovered,
    required this.updateTime,
  });

  String get name {
    final tc = Get.find<TracksController>();
    final track = tc.getTrackByID(routeId);
    return track != null ? track.name : 'not_found';
  }

  String get driverName {
    return route == null ? 'Route Not Found' : route!.driverName;
  }

  r.Route? get route {
    final rc = Get.find<RouteController>();
    final r = rc.getRoute(routeId);
    return r;
  }

  Track? get track {
    return route == null ? null : route!.track;
  }

  Tracking.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        routeId = json['route_id'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        stopCovered = json['stop_covered'],
        updateTime = stringToTimeOfDay(json['updateTime'] as String);

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "route_id": routeId,
      "latitude": latitude,
      "longitude": longitude,
      "stop_covered": stopCovered,
      "update_time": timeOfDayToString(updateTime),
    };
  }
}
