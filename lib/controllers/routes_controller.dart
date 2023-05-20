import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../models/route.dart' as r;
import '../models/route.dart';
import '../sockets/routes_api.dart';
import './users_controller.dart';
import './track/tracks_controller.dart';
import './bus_controller.dart';
import 'fetching.dart';

class RouteController extends GetxController {
  final routeState = RouteType.morning.obs;
  final indexes = <int>[].obs;
  final morning = <r.Route>[].obs;
  final evening = <r.Route>[].obs;
  final speacial = <r.Route>[].obs;
  final updateScreen = false.obs;

  final fetching = FetchingState.getting.obs;
  final _socketStream = StreamController<List<r.Route>>.broadcast();
  final api = RoutesSocketApi();

  @override
  void onInit() {
    super.onInit();
    _loadBuses();
  }

  void _loadBuses() {
    api.stream.listen((data) {
      fetching.value = FetchingState.getting;
      List<r.Route> m = [];
      List<r.Route> e = [];
      List<r.Route> s = [];

      for (int i = 0; i < data.length; i++) {
        if (data[i].type == r.RouteType.morning) {
          m.add(data[i]);
        } else if (data[i].type == r.RouteType.evening) {
          e.add(data[i]);
        } else if (data[i].type == r.RouteType.speacial) {
          s.add(data[i]);
        }
      }

      morning.clear();
      morning.addAll(m);
      evening.clear();
      evening.addAll(e);
      speacial.clear();
      speacial.addAll(s);
      fetching.value = FetchingState.done;
      // add the data to the _socketStream for other listeners
      _socketStream.add(data);
    });
    api.send(json.encode({'action': 'LOAD'}));
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
    List<mongo.ObjectId> ids = [];
    bool deleted = true;
    if (routeState.value == RouteType.morning) {
      for (int i = index.length - 1; i >= 0; i--) {
        ids.add(morning[index[i]].id);
      }
    } else if (routeState.value == RouteType.evening) {
      for (int i = index.length - 1; i >= 0; i--) {
        ids.add(evening[index[i]].id);
      }
    } else {
      for (int i = index.length - 1; i >= 0; i--) {
        ids.add(speacial[index[i]].id);
      }
    }
    deleteRoutesApi(ids);
    index.clear();

    // update table
    doUpdate();

    return deleted;
  }

  void deleteRoutesApi(List<mongo.ObjectId> ids) {
    api.send(json.encode({
      'action': 'DELETE_MULTIPLE',
      'payload': ids,
    }));
  }

  void updateRouteApi(Route r) {
    api.send(json.encode({
      'action': 'UPDATE',
      'payload': r.toJson(),
    }));
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

    updateRouteApi(r);

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
    addRouteApi(r);
    const result = true;
    return result;
  }

  void addRouteApi(Route r) {
    api.send(json.encode({
      'action': 'ADD',
      'payload': r.toJson(),
    }));
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
