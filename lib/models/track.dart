import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../functions/time.dart';

class Track {
  mongo.ObjectId id;
  String name;
  bool isAssigned;
  Track({
    required this.id,
    required this.name,
    this.isAssigned = false,
  });

  Track.fromJson(Map<String, dynamic> json)
      : id = json['_id'].runtimeType == mongo.ObjectId
            ? json['_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['_id']),
        name = json['name'],
        isAssigned = json['is_assigned'];

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "is_assigned": isAssigned,
      // "stops": stops.map((stop) => stop.toJson()).toList(),
      // "path": path.map((point) => [point[0], point[1]]).toList(),
    };
  }
}

class Stop {
  mongo.ObjectId id;
  mongo.ObjectId trackId;
  String name;
  TimeOfDay time;
  bool isStop;
  int stopNo;
  double latitude;
  double longitude;
  final isSelected = false.obs;

  Stop({
    required this.id,
    required this.trackId,
    required this.name,
    required this.time,
    required this.isStop,
    required this.stopNo,
    required this.latitude,
    required this.longitude,
  });

  Stop.fromJson(Map<String, dynamic> json)
      : id = json['_id'].runtimeType == mongo.ObjectId
            ? json['_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['_id']),
        trackId = json['track_id'].runtimeType == mongo.ObjectId
            ? json['track_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['track_id']),
        name = json['name'],
        time = stringToTimeOfDay(json['time'] as String),
        isStop = json['is_stop'],
        stopNo = json['stop_no'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() => {
        "_id": id,
        "track_id": trackId,
        "name": name,
        "time": timeOfDayToString(time),
        "is_stop": isStop,
        "stop_no": stopNo,
        "latitude": latitude,
        "longitude": longitude,
      };
}
