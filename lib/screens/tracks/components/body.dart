import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/track/tracks_controller.dart';
import '../../../dbHelper/mongo_db.dart';
import './edit_track/edit_track.dart';
import './view_track/view_track.dart';
import 'track_table/tracks_table.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TracksController>();
    return Obx(() => controller.loading.value == true
        ? const CircularProgressIndicator()
        : showTrackState(controller));
  }

  // Future<void> _insertNewTrack(BuildContext context, String name) async {
  //   var id = mongo.ObjectId();
  //   final data = MongoDbModel(id: id, name: name, isAssigned: false);

  //   await MongoDatabase.insert(data).then((value) =>
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text("Inserted ID + ${id.$oid}"))));
  // }

  Future<void> _insertTracks(
      BuildContext context, TracksController controller) async {
    await MongoDatabase.insertTrack(controller.tracks[0]).then((value) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Inserted ID + ${controller.tracks[0].id.$oid}"))));
  }

  Widget showTrackState(TracksController controller) {
    Widget widget = const SizedBox.shrink();
    if (controller.trackState.value == TrackState.tracks) {
      widget = const TracksTable();
    } else if (controller.trackState.value == TrackState.add) {
      widget = const Text('Add Track');
    } else if (controller.trackState.value == TrackState.edit) {
      widget = const EditTrack();
    } else if (controller.trackState.value == TrackState.map) {
      widget = const Text('Map Track');
    } else if (controller.trackState.value == TrackState.view) {
      widget = const ViewTrack();
    }

    return widget;
  }

  Row trackStatesButton(BuildContext ctx, TracksController controller) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => controller.setTrackState(TrackState.tracks),
          child: const Text('Tracks'),
        ),
        ElevatedButton(
          onPressed: () {
            // controller.setTrackState(TrackState.add);
            // _insertNewTrack(ctx, 'Shubano Ka Route');
          },
          child: const Text('Add'),
        ),
        ElevatedButton(
          onPressed: () {
            // controller.setTrackState(TrackState.edit),
            _insertTracks(ctx, controller);
          },
          child: const Text('Edit'),
        ),
        ElevatedButton(
          onPressed: () => controller.setTrackState(TrackState.map),
          child: const Text('Map'),
        ),
        ElevatedButton(
          // onPressed: () => controller.setTrackState(TrackState.view),
          onPressed: () => controller.getTracks(),
          child: const Text('Get Tracks'),
        ),
      ],
    );
  }

  void mongoDbFunction() {
    // print(MongoDatabase.tracksCollection.find('{"name":"route 1"}'));
  }
}
