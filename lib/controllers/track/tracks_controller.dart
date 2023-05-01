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

    if (kDebugMode) {
      print(value.runtimeType);
    }
    print(tracks.length);
    loading.value = false;
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

  void deleteTrack(int tIndex) {
    if (kDebugMode) {
      print('Removed {tracks[tIndex].name}');
    }
    tracks.removeAt(tIndex);
  }

  void deleteTrackById(mongo.ObjectId id) {
    final index = tracks.indexWhere((element) => element.id == id);
    tracks.removeAt(index);
  }

  void deleteStops(int tIndex, List<int> tStopIndex) {
    tStopIndex.sort();
    final tc = Get.find<TracksController>();
    for (int i = tStopIndex.length - 1; i >= 0; i--) {
      tc.tracks[tIndex].deleteStop(tStopIndex[i]);
    }
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
