import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Bus {
  mongo.ObjectId id;
  String numberPlate;
  int modelNo;
  bool isWorking;
  Bus({
    required this.id,
    required this.numberPlate,
    required this.modelNo,
    this.isWorking = true,
  });

  Bus.fromJson(Map<String, dynamic> json)
      : id = json['_id'].runtimeType == mongo.ObjectId
            ? json['_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['_id']),
        numberPlate = json['number_plate'],
        modelNo = json['model_no'],
        isWorking = json['is_working'];

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "number_plate": numberPlate,
      "model_no": modelNo,
      "is_working": isWorking,
    };
  }

  static Map<String, dynamic> newBusJson(String numberPlate, int modelNo) {
    return {
      "number_plate": numberPlate,
      "model_no": modelNo,
      "is_working": true,
    };
  }

  static Map<String, dynamic> updateBusJson(String numberPlate, int modelNo) {
    return {
      "number_plate": numberPlate,
      "model_no": modelNo,
      "is_working": true,
    };
  }
}
