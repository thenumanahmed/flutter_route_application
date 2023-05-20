import 'package:get/get.dart';

import './tracks_controller.dart';

enum EditBodyState { map, single, multiple }

class EditController extends GetxController {
  final selectionState = SelectionState.inActive.obs;
  final RxInt tIndex = RxInt(-1);
  static final selectedIndexes = <int>[].obs;
  static final editBodyState = EditBodyState.map.obs;
  final toUpdate = false.obs;

  @override
  void onReady() {
    // initAuth();

    super.onReady();
  }

  setExit() {
    tIndex.value = -1;
    TracksController tc = Get.find();
    tc.setTrackState(TrackState.tracks);
  }

  void setSelectedIndexed(List<int> indexes) {
    selectedIndexes.value = indexes;
    if (selectedIndexes.isEmpty) {
      editBodyState.value = EditBodyState.map;
    } else if (selectedIndexes.length == 1) {
      editBodyState.value = EditBodyState.single;
    } else {
      editBodyState.value = EditBodyState.multiple;
    }
    doUpdate();
  }

  void doUpdate() {
    toUpdate.value = !toUpdate.value;
  }

  void onDeleteSelected(
    List<int> indexes,
  ) {
    // if (kDebugMode) {
    //   print('Delete : ${indexes.toString()}');
    // }
    // print(tIndex.value);
    // Get.find<TracksController>().deleteStops(tIndex.value, indexes);
    // print('hi From on Delete Selected Edit Controllers');
    // setSelectedIndexed([]);
  }
}
