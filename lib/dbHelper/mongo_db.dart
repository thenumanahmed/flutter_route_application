import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../models/route.dart' as r;
import '../models/users.dart';
import './db_constants.dart';
import '../models/track.dart';
import '../models/bus.dart';

enum FetchingState { getting, done, error, toUpdate, idol }

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
  static DbCollection? updateCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
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
    updateCollection = db!.collection(UPDATE_COLLECTION);
  }

  static Future<int> getTrackingUpdate() async {
    final filter = where.eq('type', 'tracking');
    final result = await updateCollection!.findOne(filter);
    print(result);
    return result != null ? result['count'] as int : -1;
  }

  static Future<bool> updateTracking() async {
    final filter = where.eq('type', 'tracking');
    final update = modify.inc('count', 1); // Increment the 'count' field by 1
    final result = await stopsCollection!.update(filter, update);
    print(result);
    return result != null ? true : false;
  }

  static bool mongoResult(WriteResult result, String message) {
    if (result.isSuccess) {
      if (kDebugMode) {
        print("debug: $message successful.");
      }
      return true;
    } else {
      if (kDebugMode) {
        print("debug: $message failed.");
      }
      return false;
    }
  }

  static bool mongoDeleteResult(Map<String, dynamic>? result, String message) {
    if (result != null) {
      if (kDebugMode) {
        print("debug: $message successful.");
      }
      return true;
    } else {
      if (kDebugMode) {
        print("debug: $message failed.");
      }
      return false;
    }
  }

  static Future<bool> updateStop(Stop stop) async {
    // Define the filter to identify the document you want to update
    final filter = where.eq('_id', stop.id);

    // Perform the update operation
    final result = await stopsCollection!.replaceOne(filter, stop.toJson());

    return mongoResult(result, 'Update Stop ');
  }

  static Future<bool> insertTrack(Track data) async {
    try {
      var result = await tracksCollection!.insertOne(data.toJson());
      return mongoResult(result, 'add track');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  static Future<List<Map<String, Object?>>> getTracks() async {
    List<Map<String, Object?>> arrData =
        await tracksCollection!.find().toList();

    for (int i = 0; i < arrData.length; i++) {
      List<Map<String, Object?>> stop =
          await getTrackStops(arrData[i]['_id'] as ObjectId);
      arrData[i]['stops'] = stop;
    }
    if (kDebugMode) {}
    return arrData;
  }

  static Future<List<Map<String, Object?>>> getTrackStops(
      ObjectId trackId) async {
    final query = where.eq('track_id', trackId);
    List<Map<String, Object?>> arrData =
        await stopsCollection!.find(query).toList();

    if (kDebugMode) {}
    return arrData;
  }

  static Future<bool> addBus(Bus data) async {
    try {
      var result = await busesCollection!.insertOne(data.toJson());
      return mongoResult(result, 'add bus');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  static Future<bool> addAdmin(User data) async {
    try {
      var result = await adminsCollection!.insertOne(data.toJson());
      return mongoResult(result, 'add admin');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }

  static Future<bool> addDriver(User data) async {
    try {
      var result = await driversCollection!.insertOne(data.toJson());
      return mongoResult(result, 'add driver');
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
      return mongoResult(result, 'add Member');
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
  ///////////////////////////////
  ///////////////////////////////
  ///////////////////////////////
  ///////////////////////////////
  ///////////////////////////////
  ///////////////////////////////
  ///////////////////////////////
  ///////////////////////////////

  static Future<List<Map<String, Object?>>> getDrivers() async {
    List<Map<String, Object?>> driversList =
        await driversCollection!.find().toList();

    if (kDebugMode) {
      print(driversList.length);
      print(driversList[0]['name']);
    }
    return driversList;
  }

  static Future<List<Map<String, Object?>>> getRoutes() async {
    List<Map<String, Object?>> routesList =
        await routesCollection!.find().toList();

    if (kDebugMode) {
      print(routesList.length);
      print(routesList[0]['name']);
    }
    return routesList;
  }

  static Future<List<Map<String, Object?>>> getBuses() async {
    List<Map<String, Object?>> busesList =
        await busesCollection!.find().toList();

    if (kDebugMode) {
      print(busesList.length);
      print(busesList[0]['name']);
    }
    return busesList;
  }

  static Future<List<Map<String, Object?>>> getTrackings() async {
    List<Map<String, Object?>> trackingsList =
        await trackingCollection!.find().toList();

    if (kDebugMode) {
      print(trackingsList.length);
    }
    return trackingsList;
  }

  static Future<List<Map<String, Object?>>> getAdmins() async {
    List<Map<String, Object?>> adminsList =
        await adminsCollection!.find().toList();

    if (kDebugMode) {
      print(adminsList.length);
      print(adminsList[0]['name']);
    }
    return adminsList;
  }

  static Future<List<Map<String, Object?>>> getStops() async {
    List<Map<String, Object?>> adminsList =
        await stopsCollection!.find().toList();

    if (kDebugMode) {
      print(adminsList.length);
      print(adminsList[0]['name']);
    }
    return adminsList;
  }

  static Future<bool> addTrack(Track track) async {
    try {
      var result = await tracksCollection!.insertOne(track.toJson());
      return mongoResult(result, 'add track');
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
      // return e.toString();
      return false;
    }
  }

  static Future<bool> addStop(Stop stop) async {
    try {
      var result = await stopsCollection!.insertOne(stop.toJson());
      return mongoResult(result, 'add stop');
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
      // return e.toString();
      return false;
    }
  }

  static Future<bool> addRoute(r.Route route) async {
    try {
      var result = await routesCollection!.insertOne(route.toJson());
      return mongoResult(result, 'insert route');
    } catch (e) {
      if (kDebugMode) {
        print('debug: $e');
      }
      // return e.toString();
      return false;
    }
  }

  static Future<bool> deleteBus(ObjectId busId) async {
    final result = await busesCollection?.remove(where.id(busId));
    return mongoDeleteResult(result, 'Delete Bus'); // return true;
  }

  static Future<bool> deleteTrack(ObjectId trackId) async {
    final stopQuery = {'track_id': trackId};
    final trackQuery = where.id(trackId);
    final stopResult = await stopsCollection!.deleteMany(stopQuery);
    if (mongoResult(stopResult, 'Deleted Stop') == true) {
      final trackReult = await tracksCollection?.remove(trackQuery);
      return mongoDeleteResult(trackReult, 'Delted Track');
    }

    return false;
  }

  static Future<bool> deleteStop(ObjectId stopId) async {
    final result = await stopsCollection?.remove(where.id(stopId));
    return mongoDeleteResult(result, 'Delete Stop'); // return true;
  }

  static Future<bool> deleteRoute(ObjectId routeId) async {
    final result = await routesCollection?.remove(where.id(routeId));
    return mongoDeleteResult(result, 'Delete Route'); // return true;
  }

  static Future<bool> stopTracking(ObjectId trackingId) async {
    final result = await trackingCollection?.remove(where.id(trackingId));
    result != null ? updateTracking() : null;
    return mongoDeleteResult(result, 'Stop Tracking'); // return true;
  }

  static Future<bool> deleteAdmin(ObjectId adminId) async {
    final result = await adminsCollection?.remove(where.id(adminId));
    return mongoDeleteResult(result, 'Delete ADmin'); // return true;
  }

  static Future<bool> deleteDriver(ObjectId driverId) async {
    final result = await driversCollection?.remove(where.id(driverId));
    return mongoDeleteResult(result, 'Delete Driver'); // return true;
  }

  static Future<bool> deleteMember(ObjectId memberId) async {
    final result = await membersCollection?.remove(where.id(memberId));
    return mongoDeleteResult(result, 'Delete Member'); // return true;
  }

  static Future<bool> updateBus(Bus bus) async {
    final filter = where.eq('_id', bus.id);
    final result = await busesCollection!.replaceOne(filter, bus.toJson());
    return mongoResult(result, 'Bus Updated');
  }

  static Future<bool> updateTrack(Track track) async {
    final filter = where.eq('_id', track.id);
    final result = await tracksCollection!.replaceOne(filter, track.toJson());
    return mongoResult(result, 'Update Track');
  }

  static Future<bool> updateRoute(r.Route route) async {
    final filter = where.eq('_id', route.id);
    final result = await routesCollection!.replaceOne(filter, route.toJson());
    return mongoResult(result, 'Update Route ');
  }

  static Future<bool> updateAdmin(User admin) async {
    final filter = where.eq('_id', admin.id);
    final result = await adminsCollection!.replaceOne(filter, admin.toJson());
    return mongoResult(result, 'Update Admin');
  }

  static Future<bool> updateMembers(User member) async {
    final filter = where.eq('_id', member.id);
    final result = await membersCollection!.replaceOne(filter, member.toJson());
    return mongoResult(result, 'Update Member');
  }

  static Future<bool> updateDriver(User driver) async {
    final filter = where.eq('_id', driver.id);
    final result = await driversCollection!.replaceOne(filter, driver.toJson());
    return mongoResult(result, 'Update Driver');
  }
}












//TODO: mongo stopTracking(mongo.ObjectId trackingId)
//TODO: mogno updateAdmin(mongo.ObjectID id, User a)
//TODO: mogno updateDriver(mongo.ObjectID id, User d)
//TODO: mogno updateMember(mongo.ObjectID id, User u)
// TDOD: mongo addRoute(Route r)
//TODO: mongo deleteDriver(mongo.ObjectId id)
//TODO: mongo deleteMember(mongo.ObjectId id)
//TODO: mongo deleteAdmin(mongo.ObjectId id)
//TODO mongo getAdmin()  
//TODO mongo getMember()
//TODO mongo getDriver()
// TDOD: mongo getRoutes()
// TODO mongo getBusses()
//TODO: mongo getTrackings()
// TODO: mongo addStop(Stop t);
// TODO: getStops() - done
// TODO: mongo deleteBus(mongo.ObjectId id)
// TODO: mongo deleteTrack(mongoObjectId trackID)
// TODO: mongo delteStop(mongoObjectId StopID) 
// TDOD: mongo deleteRoute(mongo.Objectid routeId)
// TODO: mogno updateBus(mongo.ObjectID id, Bus b)
// TODO: mongo updateTrack(mongoObjectId trackID,Track t);
// TODO: mongo updateStop(mongoObjectId StopID);
// TDOD: mongo updateRoute(mongo.Objectid routeId,Route r)