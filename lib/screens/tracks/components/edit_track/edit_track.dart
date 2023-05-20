import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

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
    return Obx(
      () {
        // ec.setSelectedIndexed([]);
        ec.toUpdate.value;
        tc.stopsUpdate.value;
        pc.paths.value;
        sc.stops.value;
        final stops = sc.getStopByTrackID(tc.tracks[ec.tIndex.value].id).obs;
        final path = pc.getPathByID(tc.tracks[ec.tIndex.value].id);
        final key = stops.map((s) => s.toJson()).toString();

        print('Edit Track Screen ');
        return Column(
          children: [
            ActionButtons(
              title: 'Stop',
              add: AddStop(
                stops: stops,
              ),
              import: AddStop(
                stops: stops,
              ),
              export: AddStop(
                stops: stops,
              ),
            ),
            kHalfHeightpace,
            HeaderListArea(
              key: Key(key),
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
                onDelete: (List<int> indexes) async {
                  List<ObjectId> ids = [];
                  for (int i = 0; i < indexes.length; i++) {
                    ids.add(stops[indexes[i]].id);
                  }
                  sc.deleteStops(ids);
                  await Future.delayed(const Duration(seconds: 1));
                  ec.doUpdate();
                },
              ),
              body: Obx(() {
                ec.selectedIndexes.value;
                if (ec.editBodyState.value == EditBodyState.map) {
                  return ViewTrackMap(
                    stops: stops,
                    path: path.path,
                  );
                } else if (ec.editBodyState.value == EditBodyState.single) {
                  return EditStop(
                    key: UniqueKey(),
                    stop: stops[ec.selectedIndexes[0]],
                    tIndex: trackIndex,
                  );
                } else {
                  return EditStop(
                    stop: stops[ec.selectedIndexes[0]],
                    tIndex: trackIndex,
                    key: UniqueKey(),
                  );
                }
              }),
            ),
          ],
        );
      },
    );
  }

  SizedBox getTrackName(TracksController tc, int trackIndex) {
    return SizedBox(
      width: 250,
      height: 40,
      child: EditText(
        text: tc.tracks[trackIndex].name,
        onSave: (val) {
          tc.tracks[trackIndex].name = val;
          tc.updateTrack(tc.tracks[trackIndex]);
        },
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
