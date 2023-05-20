import 'package:dashboard_route_app/controllers/routes_controller.dart';
import 'package:dashboard_route_app/controllers/track/stops_controller.dart';
import 'package:dashboard_route_app/models/track.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../models/route.dart' as r;

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
    final rc = Get.find<RouteController>();
    final route = rc.getRoute(routeId);
    return route != null ? route.trackName : 'not_found';
  }

  String get driverName {
    return route == null ? 'Route Not Found' : route!.driverName;
  }

  r.Route? get route {
    final rc = Get.find<RouteController>();
    final r = rc.getRoute(routeId);
    return r;
  }

  String get routeName {
    final r = route;
    return r != null ? r.name : 'Not Found';
  }

  String get typeCharacter {
    final r = route;
    return r != null ? r.typeCharacter : 'N';
  }

  Track? get track {
    return route == null ? null : route!.track;
  }

  int get totalStops {
    final r = route;
    if (r != null) {
      final t = r.track;
      if (t != null) {
        return Get.find<StopsController>().getStopByTrackID(t.id).length;
      }
      return 0;
    }
    return 0;
  }

  Tracking.fromJson(Map<String, dynamic> json)
      : id = json['_id'].runtimeType == mongo.ObjectId
            ? json['_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['_id']),
        routeId = json['route_id'].runtimeType == mongo.ObjectId
            ? json['route_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['route_id']),
        latitude = json['latitude'],
        longitude = json['longitude'],
        stopCovered = json['stop_covered'],
        updateTime = stringToTimeOfDay(json['update_time'] as String);

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
