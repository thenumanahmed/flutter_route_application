import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Path {
  mongo.ObjectId id;
  List<List<double>> path;
  Path({
    required this.id,
    required this.path,
  });

  Path.fromJson(Map<String, dynamic> json)
      : id = json['_id'].runtimeType == mongo.ObjectId
            ? json['_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['_id']),
        path = (json['path'] as List<dynamic>)
            .map((e) => (e as List<dynamic>).map((e) => e as double).toList())
            .toList();

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "path": path,
    };
  }
}
