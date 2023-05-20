// ignore_for_file: invalid_use_of_protected_member

import 'package:dashboard_route_app/controllers/track/stops_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../controllers/track/paths_controller.dart';
import '../../../../controllers/track/view_controller.dart';
import '../../../../controllers/track/tracks_controller.dart';
import '../../../../functions/time.dart';
import '../../../../models/track.dart';
import '../../../../widgets/custom_data_table/table_header.dart';
import '../../../../widgets/custom_list/custom_list.dart';
import '../../../../widgets/header_list_area.dart';
import './view_track_map.dart';

class ViewTrack extends StatelessWidget {
  const ViewTrack({super.key});
  static const double stopListWidth = 250.0;
  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>(); // tracksController
    final sc = Get.find<StopsController>(); // tracksController
    final pc = Get.find<PathsController>(); // tracksController
    final vc = Get.find<ViewController>(); // tracksController

    final size = MediaQuery.of(context).size;
    final height = size.height * 0.8;
    const hideWidth = 250.0;
    final int trackIndex = vc.tIndex.value;

    return Obx(() {
      tc.stopsUpdate.value;
      pc.paths.value;
      final stops = sc.getStopByTrackID(
        tc.tracks[trackIndex].id,
      );
      final path = pc.getPathByID(tc.tracks[trackIndex].id);
      return HeaderListArea(
        height: height,
        hideSize: hideWidth,
        tableHeader: TableHeader(
          titleText: 'Track: ${tc.tracks[trackIndex].name}',
          leadingIconData: Icons.arrow_back_ios_new,
          leadingOnTap: vc.setExit,
        ),
        customList: CustomList(
          height: height,
          width: hideWidth,
          list: stops,
          getTile: getTile,
          searchBy: (value) => sc.searchByStops(stops, value),
          onSelectedIndexUpdate: vc.setSelectedIndexed,
        ),
        body: ViewTrackMap(
          stops: stops,
          path: path.path,
        ),
      );
    });
  }

  Widget getTile(dynamic s) {
    final stop = s as Stop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stop.name,
          style: const TextStyle(color: Colors.black),
        ),
        Text(
          timeOfDayToString(stop.time),
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

final List<Marker> markers = [
  Marker(
    width: 80,
    height: 80,
    point: LatLng(31.51369, 74.340846),
    builder: (ctx) => const FlutterLogo(),
  ),
  Marker(
    width: 80,
    height: 80,
    point: LatLng(31.473933, 74.386874),
    builder: (ctx) => const FlutterLogo(),
  ),
];
