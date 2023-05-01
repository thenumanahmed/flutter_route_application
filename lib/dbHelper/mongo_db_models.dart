import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String monogoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel(
      {required this.id, required this.name, required this.isAssigned});

  mongo.ObjectId id;
  String name;
  bool isAssigned;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
      id: json["_id"], name: json["name"], isAssigned: json["is_assigned"]);
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "is_assigned": isAssigned,
      };
}
