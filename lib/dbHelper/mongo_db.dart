import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/users.dart';
import './db_constants.dart';
import '../models/track.dart';
import '../models/bus.dart';

class MongoDatabase {
  static Db? db;
  static DbCollection? tracksCollection;
  static DbCollection? membersCollection;
  static DbCollection? adminsCollection;
  static DbCollection? driversCollection;
  static DbCollection? trackingCollection;
  static DbCollection? routesCollection;
  static DbCollection? busesCollection;
  static DbCollection? stopsCollection;

  static connect() async {
    // db = await Db.create(MONGO_CONN_URL);
    db = await Db.create("mongodb://localhost:27017/routeapp");
    await db!.open();
    inspect(db);
    membersCollection = db!.collection(MEMBERS_COLLECTION);
    adminsCollection = db!.collection(ADMINS_COLLECTION);
    driversCollection = db!.collection(DRIVERS_COLLECTION);
    busesCollection = db!.collection(BUSES_COLLECTION);
    tracksCollection = db!.collection(TRACKS_COLLECTION);
    routesCollection = db!.collection(ROUTES_COLLECTION);
    trackingCollection = db!.collection(TRACKING_COLLECTION);
    stopsCollection = db!.collection(STOPS_COLLECTION);
  }

  static Future<String> insertTrack(Track data) async {
    try {
      var result = await tracksCollection!.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something WentWrong with Inserting Data";
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return e.toString();
    }
  }

  static Future<List<Map<String, Object?>>> getTracks() async {
    List<Map<String, Object?>> arrData =
        await tracksCollection!.find().toList();

    if (kDebugMode) {
      print(arrData.length);
      print(arrData[0]['name']);
    }
    return arrData;
  }

  static Future<bool> addBus(Bus data) async {
    try {
      var result = await busesCollection!.insertOne(data.toJson());
      if (result.isSuccess) {
        print("debug: insertion of bus successful.");
        return true;
      } else {
        print("debug: insertion of bus failed.");
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // return e.toString();
      return false;
    }
  }

  static Future<bool> addAdmin(User data) async {
    try {
      var result = await adminsCollection!.insertOne(data.toJson());
      if (result.isSuccess) {
        print("debug: insertion of admin successful.");
        return true;
      } else {
        print("debug: insertion of admin failed.");
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // return e.toString();
      return false;
    }
  }

  static Future<bool> addDriver(User data) async {
    try {
      var result = await driversCollection!.insertOne(data.toJson());
      if (result.isSuccess) {
        print("debug: insertion of driver successful.");
        return true;
      } else {
        print("debug: insertion of driver failed.");
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
      // return e.toString();
      return false;
    }
  }

  static Future<bool> addMember(User data) async {
    try {
      var result = await membersCollection!.insertOne(data.toJson());
      if (result.isSuccess) {
        print("debug: insertion of member successful.");
        return true;
      } else {
        print("debug: insertion of member failed.");
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
      // return e.toString();
      return false;
    }
  }

  static Future<List<Map<String, Object?>>> getMembers() async {
    List<Map<String, Object?>> arrData =
        await membersCollection!.find().toList();

    if (kDebugMode) {
      print(arrData.length);
      print(arrData[0]['name']);
    }
    return arrData;
  }
}
