import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../models/track.dart';
import '../../../../widgets/flutter_map_constants.dart';

class ViewTrackMap extends StatelessWidget {
  const ViewTrackMap({
    super.key,
    required this.track,
  });

  final Track track;
  @override
  Widget build(BuildContext context) {
    final mp = MapController();

    return Flexible(
      child: FlutterMap(
        mapController: mp,
        options: MapOptions(
          onTap: (tapPosition, point) {
            if (kDebugMode) {
              print(tapPosition.toString());
              print(point.toString());
            }
          },

          maxBounds: kMaxBounds,
          center: track.stops.isNotEmpty
              ? LatLng(track.stops[0].latitude, track.stops[0].longitude)
              : kCenter,
          zoom: 15,
          maxZoom: kMaxZoom,
          minZoom: kMinZoom,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          // maxBounds: LatLngBounds([LatLng(_latitude, _longitude),LatLng(_latitude, _longitude)])
        ),
        nonRotatedChildren: [],
        children: [
          kTileLayer,
          PolylineLayer(
            polylines: getPolylines(track.path, color: Colors.blue),
          ),
          MarkerLayer(
            markers: getMarkers(track.stops),
          ),
        ],
      ),
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
