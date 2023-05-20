import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../functions/custom_snackbar.dart';
import '../models/bus.dart';
import '../sockets/buses_api.dart';
import 'fetching.dart';

class BusController extends GetxController {
  final indexes = <int>[].obs;
  final buses = <Bus>[].obs;
  final fetching = FetchingState.getting.obs;
  final _socketStream = StreamController<List<Bus>>.broadcast();
  final api = BusesSocketApi();

  @override
  void onInit() {
    super.onInit();
    _loadBuses();
  }

  void _loadBuses() {
    api.stream.listen((data) {
      fetching.value = FetchingState.getting;
      buses.clear();
      buses.addAll(data);
      fetching.value = FetchingState.done;

      // add the data to the _socketStream for other listeners
      _socketStream.add(data);
    });
    api.send(json.encode({'action': 'LOAD'}));
  }

  void addBus(Bus b) {
    api.send(json.encode({
      'action': 'ADD',
      'payload': b.toJson(),
    }));
  }

  Future<void> deleteBuses(BuildContext context, List<int> index) async {
    if (index.isEmpty) {
      customSnackbar(context, false, 'Empty Delete List');
      return;
    }

    index.sort();
    bool delete = true;

    index.sort();
    List<Bus> toDelete = [];
    for (int i = 0; i < index.length; i++) {
      toDelete.add(buses[index[i]]);
    }
    api.send(json.encode({
      'action': 'DELETE_MULTIPLE',
      'payload': toDelete.map((e) => e.id).toList(),
    }));
    indexes.clear();

    customSnackbar(context, delete, 'Delete Bus');
    indexes.clear();
  }

  List<String> get numberPlates => buses.map((bus) => bus.numberPlate).toList();

  void copyBusToClipboard() {
    final jsonList = buses.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString)).then((v) {
      if (kDebugMode) {
        print('data Copied');
      }
    });
  }

  void setIndexes(List<int> index) {
    indexes.value = index;
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    for (int i = 0; i < buses.length; i++) {
      if (buses[i].numberPlate.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }

  Bus? getBusById(mongo.ObjectId id) {
    for (int i = 0; i < buses.length; i++) {
      if (buses[i].id == id) return buses[i];
    }
    return null;
  }
}
