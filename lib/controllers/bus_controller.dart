import 'package:dashboard_route_app/functions/custom_scafold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../dbHelper/mongo_db.dart';
import '../models/bus.dart';

//TODO: mogno updateBus(mongo.ObjectID id, Bus b)

class BusController extends GetxController {
  final indexes = <int>[].obs;
  final buses = <Bus>[].obs;
  final fetching = FetchingState.getting.obs;
  // final

  @override
  void onInit() {
    initiliazeBuses();
    super.onInit();
  }

  void initiliazeBuses() async {
    fetching.value = FetchingState.getting;
    final value = await MongoDatabase.getBuses();
    List<Bus> dBuses = value.map((bus) => Bus.fromJson(bus)).toList();
    buses.value = dBuses;
    fetching.value = FetchingState.done;
  }

  Future<void> deleteBuses(BuildContext context, List<int> index) async {
    if (index.isEmpty) {
      customSnackbar(context, false, 'Empty Delete List');
      return;
    }

    index.sort();
    bool delete = true;
    for (int i = index.length - 1; i >= 0; i--) {
      MongoDatabase.deleteBus(buses[index[i]].id).then((value) {
        if (value == true) {
          buses.removeAt(index[i]);
        } else {
          delete = false;
        }
      });
    }
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
