import 'package:flutter/material.dart';
import 'custom_flutter_map.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({
    super.key,
    this.myLocationEnabled = true,
    this.minZoom = 11,
    this.maxZoom = 17,
  });
  final bool myLocationEnabled;
  final double minZoom;
  final double maxZoom;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Flexible(
          child: CustomFlutterMap(),
        ),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final CustomMapController mapController = Get.find();
  //   if (kIsWeb || kIsWeb) {
  //     // Running on the web!
  //     return MapboxMap(
  //       onMapClick: mapController.onMapClick,
  //       accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
  //       initialCameraPosition: mapController.initialCameraPosition,
  //       onMapCreated: mapController.onMapCreated,
  //       trackCameraPosition: true,
  //       cameraTargetBounds: CameraTargetBounds(LatLngBounds(
  //         northeast: const LatLng(32.219712, 74.834714),
  //         southwest: const LatLng(31.187357, 73.706143),
  //       )),
  //       // onCameraTrackingChanged: (mode) => print('Mode $mode'),
  //       myLocationEnabled: myLocationEnabled,
  //       myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
  //       minMaxZoomPreference: MinMaxZoomPreference(minZoom, maxZoom),
  //     );
  //   } else if (Platform.isWindows) {
  //     // Running on Windows!
  //     return Column(
  //       children: const [
  //         Flexible(
  //           child: CustomFlutterMap(),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return MapboxMap(
  //       onMapClick: mapController.onMapClick,
  //       accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
  //       initialCameraPosition: mapController.initialCameraPosition,
  //       onMapCreated: mapController.onMapCreated,
  //       trackCameraPosition: true,
  //       myLocationEnabled: myLocationEnabled,
  //       myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
  //       minMaxZoomPreference: MinMaxZoomPreference(minZoom, maxZoom),
  //     );
  //   }
  // }
}
