import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../models/track.dart';
import '../../../../widgets/flutter_map_constants.dart';
import '../../../models/tracking.dart';

class ViewTrackingMap extends StatelessWidget {
  const ViewTrackingMap({
    super.key,
    required this.tracking,
  });

  final Tracking tracking;
  @override
  Widget build(BuildContext context) {
    final mp = MapController();
    final track = tracking.track;
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
        center: LatLng(tracking.latitude, tracking.longitude),
        zoom: 15,
        maxZoom: kMaxZoom,
        minZoom: kMinZoom,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        // maxBounds: LatLngBounds([LatLng(_latitude, _longitude),LatLng(_latitude, _longitude)])
      ),
      nonRotatedChildren: const [],
      children: [
        kTileLayer,
        if (track != null)
          PolylineLayer(
            polylines: getPolylines(track.path, color: Colors.blue),
          ),
        if (track != null)
          MarkerLayer(
            markers: getMarkers(track.stops),
          ),
        DriverLocation(tracking: tracking),
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
