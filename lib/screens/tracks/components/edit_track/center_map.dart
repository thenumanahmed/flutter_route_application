import 'package:dashboard_route_app/configs/themes/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class CenterMap extends StatelessWidget {
  const CenterMap({
    super.key,
    required this.mc,
    required this.center,
  });
  final MapController mc;
  final LatLng center;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mc,
      options: MapOptions(
        onTap: (tapPosition, point) {
          if (kDebugMode) {
            print(tapPosition.toString());
            print(point.toString());
          }
        },

        maxBounds: LatLngBounds(
            LatLng(31.187357, 73.706143), LatLng(32.219712, 74.834714)),
        center: center,
        zoom: 15,
        maxZoom: 18.49,
        minZoom: 10.2,
        // maxBounds: LatLngBounds([LatLng(_latitude, _longitude),LatLng(_latitude, _longitude)])
      ),
      nonRotatedChildren: [
        centerMarker(),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
      ],
    );
  }

  Center centerMarker() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/icon/marker.svg",
          height: 50,
          colorFilter: getColorFilter(markerColor),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    ));
  }
}
