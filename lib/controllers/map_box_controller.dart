import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:mapbox_gl/mapbox_gl.dart';

// import 'package:flutter_map/src/core/';
// import 'package:flutter_map/flutter_map.dart' as FM;
class TapPosition {
  TapPosition(this.global, this.relative);

  Offset global;
  Offset? relative;

  @override
  bool operator ==(dynamic other) {
    if (other is! TapPosition) return false;
    final TapPosition typedOther = other;
    return global == typedOther.global && relative == other.relative;
  }

  @override
  int get hashCode => Object.hash(global, relative);
}

class CustomMapController extends GetxController {
  MapboxMapController? mapController;

  late CameraPosition initialCameraPosition;
  onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  initializeMapData() {
    initialCameraPosition = const CameraPosition(
        target: LatLng(31.535650852197616, 74.30495519811922), zoom: 15);
  }

  void animateTo(LatLng pos) {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: pos,
            zoom: 14,
            bearing: 0,
            tilt: 15,
          ),
        ),
      );
    }
  }

  void onMapClick(Point<double> point, LatLng pos) {
    if (kDebugMode) {
      print('Points: $point');
      print('Lat Lng: $pos');
    }
  }

  void onMapClickFleap(TapPosition point, LatLng pos) {
    if (kDebugMode) {
      print(point);
      print(pos);
    }
  }

  @override
  void onInit() {
    initializeMapData();
    super.onInit();
  }
}
