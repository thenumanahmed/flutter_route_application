import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/track/paths_controller.dart';
import '../../../../controllers/track/stops_controller.dart';
import '../../../../controllers/track/tracks_controller.dart';
import '../../../../controllers/track/edit_controller.dart';
import '../../../../functions/time.dart';
import '../../../../models/track.dart';
import '../../../../widgets/custom_data_table/action_buttons.dart';
import '../../../../widgets/custom_data_table/table_header.dart';
import '../../../../widgets/custom_list/custom_list.dart';
import '../../../../widgets/edit_text.dart';
import '../../../../widgets/header_list_area.dart';
import '../view_track/view_track_map.dart';

import './edit_stop.dart';
import './add_stop.dart';

class EditTrack extends StatelessWidget {
  const EditTrack({super.key});
  static const double stopListWidth = 250.0;

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>(); // tracksController
    final sc = Get.find<StopsController>(); //stopsController
    final pc = Get.find<PathsController>(); //stopsController
    final ec = Get.find<EditController>(); // editController

    final size = MediaQuery.of(context).size;
    final height = size.height * 0.75;
    const hideWidth = 250.0;
    final trackIndex = ec.tIndex.value;
    return Column(
      children: [
        const ActionButtons(
          title: 'Stop',
          add: AddStop(),
          import: AddStop(),
          export: AddStop(),
        ),
        kHalfHeightpace,
        Obx(() {
          ec.toUpdate.value;
          tc.stopsUpdate.value;
          pc.paths.value;
          final stops = sc.getStopByTrackID(tc.tracks[ec.tIndex.value].id);
          final path = pc.getPathByID(tc.tracks[ec.tIndex.value].id);
          return HeaderListArea(
            height: height,
            hideSize: hideWidth,
            tableHeader: TableHeader(
              title: getTrackName(tc, trackIndex),
              leadingIconData: Icons.arrow_back_ios_new,
              leadingOnTap: ec.setExit,
            ),
            customList: CustomList(
              height: height,
              width: hideWidth,
              list: stops,
              getTile: getTile,
              searchBy: (value) => sc.searchByStops(stops, value),
              onSelectedIndexUpdate: ec.setSelectedIndexed,
              onDelete: ec.onDeleteSelected,
            ),
            body: Obx(() {
              if (ec.editBodyState.value == EditBodyState.map) {
                return ViewTrackMap(
                  stops: stops,
                  path: path.path,
                );
              } else if (ec.editBodyState.value == EditBodyState.single) {
                return EditStop(
                  stop: stops[ec.selectedIndexes[0]],
                  tIndex: trackIndex,
                  key: UniqueKey(),
                );
              } else {
                return EditStop(
                  stop: stops[ec.selectedIndexes[0]],
                  tIndex: trackIndex,
                  key: UniqueKey(),
                );
              }
            }),
          );
        }),
      ],
    );
  }

  SizedBox getTrackName(TracksController tc, int trackIndex) {
    return SizedBox(
      width: 250,
      height: 40,
      child: EditText(
        text: tc.tracks[trackIndex].name,
        onSave: (val) => tc.tracks[trackIndex].name = val,
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget getTile(dynamic s) {
    final stop = s as Stop;
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stop.name,
            style: const TextStyle(color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            timeOfDayToString(stop.time),
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
