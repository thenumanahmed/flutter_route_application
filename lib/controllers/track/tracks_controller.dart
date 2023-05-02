import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../dbHelper/mongo_db.dart';
import '../../models/track.dart';
import '../tracks_data/track1.dart';
import '../tracks_data/track2.dart';
import '../tracks_data/track3.dart';
import '../tracks_data/track4.dart';
import '../tracks_data/track5.dart';
import '../tracks_data/track6.dart';
import '../tracks_data/track7.dart';

// TODO: getTracks() - done
// TODO: mongo addTrack(Track t);
// TODO: mongo delteTrack(mongoObjectId trackID)
// TODO: mongo updateTrack(mongoObjectId trackID,Track t);

// TODO: getStops() - done
// TODO: mongo addStop(Stop t);
// TODO: mongo delteStop(mongoObjectId StopID)
// TODO: mongo updateStop(mongoObjectId StopID);

enum TrackState { tracks, view, add, edit, delete, map }

enum SelectionState { active, inActive }

class TracksController extends GetxController {
  final trackState = TrackState.tracks.obs;
  final id = mongo.ObjectId().obs;
  List<String> get names => tracks.map((track) => track.name).toList();
  final loading = true.obs;

  final tracks = [
    track1,
    track2,
    track3,
    track4,
    track5,
    track6,
    track7,
  ].obs;
  @override
  void onReady() {
    getTracks();

    super.onReady();
  }

  void getTracks() async {
    final value = await MongoDatabase.getTracks();
    List<Track> tTracks = value.map((track) => Track.fromJson(track)).toList();
    tracks.value = tTracks;
    loading.value = false;
  }

  void deleteTrack(int tIndex) {
    // TODO: Mongo deleteTrack(mongoObjectId trackID)
    // you can get track id to delte by tracks[tIndex].id
    // if fail return 0;
    // else remove track local by track.removeAt(tIndex)

    if (kDebugMode) {
      print('Removed ${tracks[tIndex].name}');
    }

    // Delete Success in mongo delete from here
    tracks.removeAt(tIndex);
  }

  void deleteTrackById(mongo.ObjectId id) {
    final index = tracks.indexWhere((element) => element.id == id);

    // TODO Mongo delteTrack(mongoObjectId trackID)
    // if index -1 return
    // perform delete from mongo
    // if succes then remove local tracks.removeAt(index)

    tracks.removeAt(index);
  }

  void deleteStops(int tIndex, List<int> tStopIndex) {
    tStopIndex.sort();
    final tc = Get.find<TracksController>();
    for (int i = tStopIndex.length - 1; i >= 0; i--) {
      // TODO Mongo delteStop(mongo.ObjectId trackID,mongo.ObjectId stopID)
      final stopId = tc.tracks[tIndex].stops[tStopIndex[i]].id;

      MongoDatabase.deleteStop(stopId).then((value) {
        if (value == true) {
        } else {}
      });
      // if succes then delete local tc.tracks[tIndex].deleteStop(tStopIndex[i]);
      tc.tracks[tIndex].deleteStop(tStopIndex[i]);
    }
  }

  void setTrackState(TrackState value) {
    trackState.value = value;
    const TimeOfDay(hour: 06, minute: 30).toString();
  }

  Track? getTrackByID(mongo.ObjectId id) {
    int index = tracks.indexWhere((element) => element.id == id);
    return index > -1 ? tracks[index] : null;
  }

  int getIndexByTrackID(mongo.ObjectId id) {
    return tracks.indexWhere((element) => element.id == id);
  }

  void setStopIsSelected(int tIndex, int sIndex, bool value) {
    tracks[tIndex].stops[sIndex].isSelected.value = value;
  }

  bool getStopIsSelected(int tIndex, int sIndex) {
    return tracks[tIndex].stops[sIndex].isSelected.value;
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    final tc = Get.find<TracksController>();
    for (int i = 0; i < tc.tracks.length; i++) {
      if (tc.tracks[i].name.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }

  void copyTracksToClipboard() {
    final jsonList = tracks.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString))
        .then((v) => print('data Copied'));
  }
}
