import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../models/bus.dart';

//TODO mongo getBusses()
//TODO: mongo addBus(Bus b)
//TODO: mongo deleteBus(mongo.ObjectId id)
//TODO: mogno updateBus(mongo.ObjectID id, Bus b)

class BusController extends GetxController {
  final indexes = <int>[].obs;
  final buses = <Bus>[
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK001', modelNo: 1),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK002', modelNo: 2),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK003', modelNo: 3),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK004', modelNo: 4),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK005', modelNo: 5),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK006', modelNo: 6),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK007', modelNo: 7),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK008', modelNo: 8),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK009', modelNo: 9),
    Bus(id: mongo.ObjectId(), numberPlate: 'LEK010', modelNo: 10),
  ].obs;
  // final
  List<String> get numberPlates => buses.map((bus) => bus.numberPlate).toList();

  void copyBusToClipboard() {
    final jsonList = buses.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString))
        .then((v) => print('data Copied'));
  }

  @override
  void onReady() {
    // initAuth();

    super.onReady();
  }

  void initilizedData() {
    // TODO: getBuses()
    // set fetching.value = FetchingState.loading
    // get data from mongo db
    // if success store values in buses list and set fetching.value = FetchingState.completed
    // else set fetching.value = LoadingState.Error
    //
  }
  void deleteBuses(List<int> index) {
    index.sort();
    for (int i = index.length - 1; i >= 0; i--) {
      // TODO: Mongo delteBus(mongo.ObjectId busId)
      // if succes then delete local buses.removeAt(index[i]);
      buses.removeAt(index[i]);
    }
    indexes.clear();
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
