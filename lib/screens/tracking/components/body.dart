import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_hide_area.dart';
import '../../../widgets/custom_list/custom_list.dart';
import '../../../widgets/custom_map/custom_map.dart';
import '../../../controllers/tracking_controller.dart';
import 'tracking_detail.dart';
import 'tracking_tile.dart';
import 'view_tracking_map.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  final listWidth = 250.0;
  final messageHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    final tgc = Get.find<TrackingController>();
    final size = MediaQuery.of(context).size;
    final height = size.height - 100;

    return CustomHideArea(
      height: height,
      hideSize: listWidth,
      allwaysHide: false,
      message: 'Show Driver',
      hide: Obx(
        () {
          // ignore: invalid_use_of_protected_member
          tgc.indexes.value;
          print(tgc.trackings.length);
          return CustomList(
            deleteMessage: 'Stop Tracking',
            searchMessage: 'Search Routes',
            deleteIcon: Icons.stop_circle_outlined,
            height: height,
            onDelete: tgc.stopTracking,
            getTile: (tracking) => TrackingTile(
              listWidth: listWidth,
              tracking: tracking,
            ),
            searchBy: tgc.searchByName,
            onSelectedIndexUpdate: tgc.setIndexes,
            list: tgc.trackings,
          );
        },
      ),
      main: Obx(() {
        int index = tgc.indexes.isNotEmpty ? tgc.indexes[0] : 0;
        tgc.indexes.value;
        print('hi');
        print('index $index');
        return CustomHideArea(
            height: height,
            // hideSize: messageHeight,
            allwaysHide: true,
            buttonBackground: Colors.black,
            buttonForeground: Colors.white,
            hidePos: HidePos.bottom,
            message: 'Show Details',
            hide: (tgc.trackingState.value == TrackingState.map)
                ? const SizedBox.shrink()
                : TrackingDetails(height: messageHeight),
            main: ViewTrackingMap(
              key: UniqueKey(),
              tracking: tgc.trackings[index],
            ));
      }),
    );
  }

  onStop(List<int> indexes) {}

  onSelectedIndexUpdate(List<int> indexes) {}

  List<int> searchBy(val) {
    return [0, 1];
  }
}
