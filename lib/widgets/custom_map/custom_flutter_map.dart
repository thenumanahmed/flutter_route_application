import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class CustomFlutterMap extends StatelessWidget {
  const CustomFlutterMap({super.key, this.markers = const []});
  final List<Marker> markers;
  @override
  Widget build(BuildContext context) {
    final mp = MapController();

    return FlutterMap(
      mapController: mp,
      options: MapOptions(
        onTap: (tapPosition, point) {
          if (kDebugMode) {
            print(tapPosition.toString());
            print(point.toString());
          }
        },

        maxBounds: LatLngBounds(
            LatLng(31.187357, 73.706143), LatLng(32.219712, 74.834714)),
        center: LatLng(31.535650852197616, 74.30495519811922),
        zoom: 15,
        maxZoom: 18.49,
        minZoom: 10.2,
        // maxBounds: LatLngBounds([LatLng(_latitude, _longitude),LatLng(_latitude, _longitude)])
      ),
      nonRotatedChildren: const [],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(
          markers: [...markers],
        ),
        // MarkerLayer(markers: markers),
      ],
    );
  }
}
