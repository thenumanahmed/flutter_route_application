import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../models/path.dart';
import '../../sockets/paths_api.dart';
import '../fetching.dart';
import './tracks_controller.dart';

class PathsController extends GetxController {
  final fetching = FetchingState.getting.obs;
  final paths = <Path>[].obs;
  final valueUpadte = false.obs;

  final _socketStream = StreamController<List<Path>>.broadcast();
  final api = PathsSocketApi();

  @override
  void onInit() {
    super.onInit();
    _loadPaths();
  }

  doUpdate() {
    valueUpadte.value = !valueUpadte.value;
  }

  void _loadPaths() {
    print('Paths');
    api.stream.listen((data) {
      print('path $data');
      fetching.value = FetchingState.getting;
      TracksController.loading.value = true;
      paths.clear();
      paths.addAll(data);
      TracksController.loading.value = false;
      fetching.value = FetchingState.done;
      Get.find<TracksController>().signalStopsUpdate();
      // add the data to the _socketStream for other listeners
      _socketStream.add(data);
    });
    api.send(json.encode({'action': 'LOAD'}));
  }

  Path getPathByID(mongo.ObjectId id) {
    for (int i = 0; i < paths.length; i++) {
      if (paths[i].id == id) return paths[i];
    }
    return Path(id: id, path: []);
  }

  void addPath(Path s) {}
  void updatePath(Path s) {}
  void deletePath(mongo.ObjectId id) {}
}
