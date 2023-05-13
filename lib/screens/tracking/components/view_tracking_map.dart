import 'package:dashboard_route_app/controllers/track/paths_controller.dart';
import 'package:dashboard_route_app/controllers/track/stops_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../../../models/track.dart';
import '../../../../models/path.dart' as p;

import '../../../../widgets/flutter_map_constants.dart';
import '../../../configs/map/flutter_map.dart';
import '../../../models/tracking.dart';

class ViewTrackingMap extends StatelessWidget {
  const ViewTrackingMap({
    super.key,
    required this.tracking,
  });

  final Tracking? tracking;
  @override
  Widget build(BuildContext context) {
    Track? track;
    List<Stop> stops = [];
    p.Path path = p.Path(id: mongo.ObjectId(), path: []);
    final mp = MapController();
    if (tracking != null) {
      track = tracking!.track;
      if (track != null) {
        stops = Get.find<StopsController>().getStopByTrackID(track.id);
        path = Get.find<PathsController>().getPathByID(track.id);
      }
    }
    return FlutterMap(
      mapController: mp,
      options: MapOptions(
        onTap: (tapPosition, point) {
          if (kDebugMode) {
            print(tapPosition.toString());
            print(point.toString());
          }
        },

        maxBounds: kMaxBounds,
        center: tracking != null
            ? LatLng(tracking!.latitude, tracking!.longitude)
            : kUetKskPoint,
        zoom: 15,
        maxZoom: kMaxZoom,
        minZoom: kMinZoom,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        // maxBounds: LatLngBounds([LatLng(_latitude, _longitude),LatLng(_latitude, _longitude)])
      ),
      nonRotatedChildren: const [],
      children: [
        kTileLayer,
        if (tracking != null && track != null)
          PolylineLayer(
            polylines: getPolylines(path.path, color: Colors.blue),
          ),
        if (tracking != null && track != null)
          MarkerLayer(
            markers: getMarkers(stops),
          ),
        if (tracking != null) DriverLocation(tracking: tracking!),
      ],
    );
  }
}

List<Marker> getMarkers(List<Stop> stops) {
  return List.generate(
      stops.length,
      (index) => getMarker(
            LatLng(stops[index].latitude, stops[index].longitude),
            message: stops[index].name,
          ));
}

class DriverLocation extends StatelessWidget {
  const DriverLocation({super.key, required this.tracking});
  final Tracking tracking;
  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        getDriver(LatLng(tracking.latitude, tracking.longitude)),
      ],
    );
  }
}
