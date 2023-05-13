import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../functions/time.dart';

class Track {
  mongo.ObjectId id;
  String name;
  List<Stop> stops;
  List<List<double>> path;
  bool isAssigned;
  Track({
    required this.id,
    required this.name,
    this.isAssigned = false,
    this.stops = const <Stop>[],
    this.path = const [],
  });
  List<int> getStopsBy(String s) {
    List<int> list = [];
    for (int i = 0; i < stops.length; i++) {
      if (stops[i].name.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }

  Track.fromJson(Map<String, dynamic> json)
      : id = json['_id'].runtimeType == mongo.ObjectId
            ? json['_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['_id']),
        name = json['name'],
        isAssigned = json['is_assigned'],
        stops = <Stop>[],
        path = <List<double>>[] {
    print('Tracks Json Called');
    // code to assign stops as well

    // if (json['stops'] != null) {
    //   stops = <Stop>[];
    //   // add code here to get json of Stops
    //   json['stops'].forEach((v) {
    //     stops.add(Stop.fromJson(v));
    //   });
    // }
    // if (json['path'] != null) {
    //   path = <List<double>>[];
    //   json['path'].forEach((v) {
    //     path.add([v[0], v[1]]);
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    if (kDebugMode) {
      print(path);
      print(path.map((point) => [point[0], point[1]]).toList());
    }
    return {
      "_id": id,
      "name": name,
      "is_assigned": isAssigned,
      // "stops": stops.map((stop) => stop.toJson()).toList(),
      // "path": path.map((point) => [point[0], point[1]]).toList(),
    };
  }

  setStopSelected(int index) {
    stops[index].isSelected.value = true;
  }

  setStopUnSelected(int index) {
    stops[index].isSelected.value = false;
  }

  setStopsUnSelected() {
    for (int i = 0; i < stops.length; i++) {
      stops[i].isSelected.value = false;
    }
  }

  void deleteStop(int index) {
    stops.removeAt(index);
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
