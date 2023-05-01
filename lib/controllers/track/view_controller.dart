import 'package:get/get.dart';

import 'tracks_controller.dart';

class ViewController extends GetxController {
  final selectionState = SelectionState.inActive.obs;
  final RxInt tIndex = RxInt(-1);
  final selectedIndexes = <int>[].obs;

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
  }
}
