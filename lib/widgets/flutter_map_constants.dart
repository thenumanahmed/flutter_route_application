import 'package:dashboard_route_app/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final kMaxBounds =
    LatLngBounds(LatLng(31.187357, 73.706143), LatLng(32.219712, 74.834714));

final kCenter = LatLng(31.535650852197616, 74.30495519811922);

const double kMaxZoom = 18.49;
const double kMinZoom = 10.2;

final kAttributionWidget = AttributionWidget.defaultWidget(
  source: 'OpenStreetMap contributors',
  onSourceTapped: () {},
);

final kTileLayer = TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);

List<Polyline> getPolylines(
  List<List<double>> path, {
  Color color = Colors.black,
  double width = 4,
}) {
  final polyLines = [
    Polyline(
      points: List.generate(
          path.length, (index) => LatLng(path[index][1], path[index][0])),
      strokeWidth: width,
      color: color,
    ),
  ];

  return polyLines;
}

Marker getMarker(
  LatLng point, {
  double size = 40,
  String message = '',
  IconData icon = Icons.location_on,
  Color color = Colors.red,
  bool isAbove = true,
}) {
  return Marker(
    rotate: true,
    // width: ,
    height: isAbove ? size * 2 : size,
    point: point,
    builder: (ctx) => Tooltip(
      message: message,
      verticalOffset: isAbove ? 0 : null,
      child: Column(
        children: [
          Icon(
            icon,
            size: size,
            color: color,
          ),
          SizedBox(
            height: isAbove ? size : 0,
          )
        ],
      ),
    ),
  );
}

Marker getDriver(
  LatLng point, {
  double size = 50,
}) {
  return Marker(
    rotate: true,
    height: size,
    width: size,
    point: point,
    builder: (ctx) => Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(size)),
      padding: const EdgeInsets.all(defaultPadding / 4),
      child: const Tooltip(
        message: 'Driver Location',
        child: Icon(
          Icons.directions_bus_rounded,
          color: Colors.blue,
        ),
      ),
    ),
  );
}
