import 'dart:convert';

import 'package:dashboard_route_app/dbHelper/mongo_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../models/route.dart' as r;
import '../models/route.dart';
import './users_controller.dart';
import './track/tracks_controller.dart';
import './bus_controller.dart';

class RouteController extends GetxController {
  final fetching = FetchingState.getting.obs;

  final routeState = RouteType.morning.obs;
  final indexes = <int>[].obs;
  final morning = <r.Route>[].obs;
  final evening = <r.Route>[].obs;
  final speacial = <r.Route>[].obs;
  final updateScreen = false.obs;

  @override
  void onReady() {
    // initAuth();
    initializeData();
    super.onReady();
  }

  void initializeData() async {
    fetching.value = FetchingState.getting;
    final value = await MongoDatabase.getRoutes();
    List<Route> dRoutes = value.map((route) => Route.fromJson(route)).toList();
    for (int i = 0; i < dRoutes.length; i++) {
      if (dRoutes[i].type == RouteType.morning) {
        morning.add(dRoutes[i]);
      } else if (dRoutes[i].type == RouteType.evening) {
        evening.add(dRoutes[i]);
      } else {
        speacial.add(dRoutes[i]);
      }
    }
    fetching.value = FetchingState.done;
  }

  // TDOD: mongo addRoute(Route r)
  // TDOD: mongo deleteRoute(mongo.Objectid routeId)

  // final
  void copyMorningToClipboard() {
    final jsonList = morning.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString)).then((v) {
      if (kDebugMode) {
        print('data Copied');
      }
    });
  }

  void copyEveningToClipboard() {
    final jsonList = evening.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString)).then((v) {
      if (kDebugMode) {
        print('data Copied');
      }
    });
  }

  void copySpeacialToClipboard() {
    final jsonList = speacial.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString)).then((v) {
      if (kDebugMode) {
        print('data Copied');
      }
    });
  }

  Route currentRoute(int index) {
    if (routeState.value == RouteType.morning) {
      return morning[index];
    } else if (routeState.value == RouteType.morning) {
      return evening[index];
    } else {
      return speacial[index];
    }
  }

  Route? getRoute(mongo.ObjectId id) {
    int index = morning.indexWhere((route) => route.id == id);
    if (index != -1) return morning[index];

    index = evening.indexWhere((route) => route.id == id);
    if (index != -1) return evening[index];

    index = evening.indexWhere((route) => route.id == id);
    if (index != -1) return speacial[index];

    return null;
  }

  void doUpdate() {
    updateScreen.value = !updateScreen.value;
  }

  Future<bool> selectionDelete(List<int> index) async {
    index.sort();

    bool deleted = true;
    if (routeState.value == RouteType.morning) {
      for (int i = index.length - 1; i >= 0; i--) {
        final res = await MongoDatabase.deleteRoute(morning[index[i]].id);
        if (res == true) {
          morning.removeAt(index[i]);
        } else {
          deleted = false;
        }
      }
    } else if (routeState.value == RouteType.evening) {
      for (int i = index.length - 1; i >= 0; i--) {
        final res = await MongoDatabase.deleteRoute(evening[index[i]].id);
        if (res == true) {
          evening.removeAt(index[i]);
        } else {
          deleted = false;
        }
      }
    } else {
      for (int i = index.length - 1; i >= 0; i--) {
        final res = await MongoDatabase.deleteRoute(speacial[index[i]].id);
        if (res == true) {
          speacial.removeAt(index[i]);
        } else {
          deleted = false;
        }
      }
    }
    index.clear();

    // update table
    doUpdate();

    return deleted;
  }

  Future<bool> updateRoute({
    required int index,
    required String name,
    required mongo.ObjectId? trackId,
    required mongo.ObjectId? driverId,
    required mongo.ObjectId? busId,
  }) async {
    // Get Route Object
    late Route r;
    if (routeState.value == RouteType.morning) {
      r = morning[index];
    } else if (routeState.value == RouteType.morning) {
      r = evening[index];
    } else {
      r = speacial[index];
    }

    r.name = name;
    r.trackId = trackId;
    r.driverId = driverId;
    r.busId = busId;

    final res = await MongoDatabase.updateRoute(r);
    if (res == false) return false;

    if (routeState.value == RouteType.morning) {
      morning[index] = r;
    } else if (routeState.value == RouteType.evening) {
      evening[index] = r;
    } else {
      speacial[index] = r;
    }
    doUpdate();
    return true;
  }

  Future<bool> addRoute(Route r) async {
    final result = await MongoDatabase.addRoute(r);
    if (result == true) {
      if (r.type == RouteType.morning) {
        morning.add(r);
      } else if (r.type == RouteType.evening) {
        evening.add(r);
      } else {
        speacial.add(r);
      }
      doUpdate();
    }
    return result;
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    List<r.Route> route;
    if (routeState.value == RouteType.morning) {
      route = morning;
    } else if (routeState.value == RouteType.evening) {
      route = evening;
    } else {
      route = speacial;
    }
    for (int i = 0; i < route.length; i++) {
      if (route[i].name.toUpperCase().contains(s.toUpperCase())) {
        list.add(i);
      }
    }
    return list;
  }

  mongo.ObjectId? stringToBusId(String numberPlate) {
    final bc = Get.find<BusController>();
    int bIndex = bc.buses.indexWhere((bus) => bus.numberPlate == numberPlate);
    return bIndex != -1 ? bc.buses[bIndex].id : null;
  }

  mongo.ObjectId? stringToDriverId(String username) {
    final dc = Get.find<UsersController>();
    int dIndex = dc.drivers.indexWhere((driver) => driver.username == username);
    return dIndex != -1 ? dc.drivers[dIndex].id : null;
  }

  mongo.ObjectId? stringToTrackId(String name) {
    final tc = Get.find<TracksController>();
    int tIndex = tc.tracks.indexWhere((track) => track.name == name);
    return tIndex != -1 ? tc.tracks[tIndex].id : null;
  }

  List<List<r.Route>> getDefaultValues() {
    final tc = Get.find<TracksController>();
    final uc = Get.find<UsersController>();
    final bc = Get.find<BusController>();

    List<r.Route> routes = [
      r.Route(
        id: mongo.ObjectId(),
        name: '4',
        type: r.RouteType.morning,
        trackId: tc.tracks[0].id,
        busId: bc.buses[0].id,
        driverId: uc.drivers[0].id,
      ),
      r.Route(
        id: mongo.ObjectId(),
        name: '4',
        type: r.RouteType.evening,
        trackId: tc.tracks[1].id,
        busId: bc.buses[1].id,
        driverId: uc.drivers[1].id,
      ),
      r.Route(
        id: mongo.ObjectId(),
        name: '5',
        type: r.RouteType.morning,
        trackId: tc.tracks[2].id,
        busId: bc.buses[2].id,
        driverId: uc.drivers[2].id,
      ),
      r.Route(
        id: mongo.ObjectId(),
        name: '5',
        type: r.RouteType.evening,
        trackId: tc.tracks[3].id,
        busId: bc.buses[3].id,
        driverId: uc.drivers[3].id,
      ),
      r.Route(
        id: mongo.ObjectId(),
        name: '6',
        type: r.RouteType.morning,
        trackId: tc.tracks[4].id,
        busId: bc.buses[4].id,
        driverId: uc.drivers[4].id,
      ),
      r.Route(
        id: mongo.ObjectId(),
        name: '6',
        type: r.RouteType.evening,
        trackId: tc.tracks[5].id,
        busId: bc.buses[5].id,
        driverId: uc.drivers[5].id,
      ),
      r.Route(
        id: mongo.ObjectId(),
        name: 'Rana Town',
        type: r.RouteType.morning,
        trackId: tc.tracks[6].id,
        busId: bc.buses[6].id,
        driverId: uc.drivers[6].id,
      ),
    ];

    List<r.Route> tMorning = [];
    List<r.Route> tEvening = [];
    List<r.Route> tSpeacial = [];

    for (int i = 0; i < routes.length; i++) {
      if (routes[i].type == r.RouteType.morning) {
        tMorning.add(routes[i]);
      } else if (routes[i].type == r.RouteType.evening) {
        tEvening.add(routes[i]);
      } else {
        tSpeacial.add(routes[i]);
      }
    }

    return [tMorning, tEvening, tSpeacial];
  }
}
