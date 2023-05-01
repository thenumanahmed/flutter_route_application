import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/themes/ui_parameters.dart';
import '../../../../controllers/track/view_controller.dart';
import '../../../../models/track.dart';
import '../../../../controllers/track/tracks_controller.dart';
import '../../../../controllers/track/edit_controller.dart';
import '../../../../responsive.dart';
import '../../../../widgets/custom_data_table/custom_data_table.dart';
import '../../../../widgets/custom_icon_button.dart';
import './add_track.dart';

class TracksTable extends StatelessWidget {
  const TracksTable({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = Get.find<TracksController>();
    final avaliableWidth = Responsive.avaliableWidth(context);
    final tableWidth =
        avaliableWidth >= 650.0 ? (avaliableWidth - defaultPadding * 4) : 650.0;

    return Obx(
      () => CustomDataTable(
        add: const AddTrack(),
        import: const Text('Add'),
        export: const Text('Add'),
        selectionImport: selectionImport,
        selectionDelete: selectionDelete,
        title: 'Tracks',
        tableWidth: tableWidth,
        dataColumn: getTrackDataColumn(context),
        getDataCell: getTrackDataCells,
        searchBy: tc.searchByName,
        // ignore: invalid_use_of_protected_member
        list: tc.tracks.value,
      ),
    );
  }

  List<DataColumn> getTrackDataColumn(BuildContext context) {
    return [
      const DataColumn(
        label: Text(
          'Track Name',
        ),
      ),
      const DataColumn(
        label: Text(
          'Total Stops',
        ),
      ),
      const DataColumn(
        label: Text(
          'Is Assigned',
        ),
      ),
      const DataColumn(
        label: Text(
          'Operations',
        ),
      )
    ];
  }

  List<DataCell> getTrackDataCells(
    dynamic data,
    int index,
  ) {
    final track = data as Track;
    return [
      DataCell(
        Text(track.name, softWrap: true),
      ),
      DataCell(Text(track.stops.length.toString())),
      DataCell(Text(track.isAssigned ? "Yes" : "No")),
      DataCell(Row(
        children: [
          CustomIconButton(
            onTap: () => seeTrack(index),
            message: 'See Map',
            svgIcon: 'assets/icons/map.svg',
            color: Colors.green,
          ),
          CustomIconButton(
            onTap: () => editTrack(index),
            message: 'Edit Track',
            icon: Icons.edit,
            color: Colors.blue,
          ),
          CustomIconButton(
            onTap: () => deleteTrack(index),
            message: 'Delete Track',
            icon: Icons.delete_forever,
            color: Colors.red,
          ),
        ],
      )),
    ];
  }

  void add() {
    if (kDebugMode) {
      print('Add');
    }
  }

  void import() {
    if (kDebugMode) {
      print('Import');
    }
  }

  void export() {
    if (kDebugMode) {
      print('Export');
    }
  }

  void selectionImport(List<int> indexes) {
    if (kDebugMode) {
      print('Selection Import : ${indexes.toString()}');
    }
  }

  void selectionDelete(List<int> indexes) {
    if (kDebugMode) {
      print('Selection Delete : ${indexes.toString()}');
    }
  }

  void seeTrack(int index) {
    final tc = Get.find<TracksController>();
    final vc = Get.find<ViewController>();
    vc.tIndex.value = index;
    tc.setTrackState(TrackState.view);
  }

  void editTrack(int index) {
    final tc = Get.find<TracksController>();
    final ec = Get.find<EditController>();
    ec.tIndex.value = index;
    tc.setTrackState(TrackState.edit);
  }

  void deleteTrack(int index) {
    final tc = Get.find<TracksController>();
    tc.deleteTrack(index);
  }

  List<int> searchByName(String s) {
    List<int> list = [];
    final tc = Get.find<TracksController>();
    for (int i = 0; i < tc.tracks.length; i++) {
      if (tc.tracks[i].name.capitalize!.contains(s.capitalize!)) {
        list.add(i);
      }
    }
    return list;
  }
}
