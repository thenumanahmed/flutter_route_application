import 'package:dashboard_route_app/controllers/bus_controller.dart';
import 'package:dashboard_route_app/controllers/track/tracks_controller.dart';
import 'package:dashboard_route_app/models/track.dart';
import 'package:dashboard_route_app/models/users.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../controllers/users_controller.dart';
import 'bus.dart';

enum RouteType { morning, evening, speacial }

class Route {
  mongo.ObjectId id;
  String name;
  RouteType type;
  mongo.ObjectId? trackId;
  mongo.ObjectId? busId;
  mongo.ObjectId? driverId;

  static const String notFound = "not_found";
  Route({
    required this.id,
    required this.name,
    required this.type,
    this.trackId,
    this.busId,
    this.driverId,
  });

  Route.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as mongo.ObjectId,
        name = json['name'],
        type = stringToRouteType(json['type'] as String),
        trackId = json['track_id'],
        driverId = json['driver_id'],
        busId = json['bus_id'];

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "type": routeTypeToString(type),
      "track_id": trackId,
      "driver_id": driverId,
      "bus_id": busId,
    };
  }

  Track? get track => trackId == null
      ? null
      : Get.find<TracksController>().getTrackByID(trackId!);

  User? get driver => driverId == null
      ? null
      : Get.find<UsersController>().getUserByID(driverId!, UserType.driver);

  Bus? get bus =>
      busId == null ? null : Get.find<BusController>().getBusById(busId!);

  String get trackName => track != null ? track!.name : notFound;
  String get driverName => driver != null ? driver!.username : notFound;
  String get busNumber => bus != null ? bus!.numberPlate : notFound;

  static RouteType stringToRouteType(String routeType) {
    if (routeType == 'Morning') {
      return RouteType.morning;
    } else if (routeType == 'Evening') {
      return RouteType.evening;
    } else {
      return RouteType.speacial;
    }
  }

  static String routeTypeToString(RouteType routeType) {
    if (routeType == RouteType.morning) {
      return 'Morning';
    } else if (routeType == RouteType.evening) {
      return 'Evening';
    } else {
      return 'Special';
    }
  }
}
