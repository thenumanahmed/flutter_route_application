import 'package:latlong2/latlong.dart';

LatLng stringToLatLng(String s) {
  List<String> parts = s.split(",");
  double lat = double.parse(parts[0]);
  double lon = double.parse(parts[1]);

  return LatLng(lat, lon);
}

String latLngToString(LatLng p) {
  return "${p.latitude},${p.longitude}";
}
