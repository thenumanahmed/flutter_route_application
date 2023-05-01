import 'package:mongo_dart/mongo_dart.dart' as mongo;

class LastMessage {
  mongo.ObjectId senderId;
  DateTime timestamp;
  String content;
  LastMessage({
    required this.senderId,
    required this.timestamp,
    required this.content,
  });

  LastMessage.fromJson(Map<String, dynamic> json)
      : senderId = json['sender_id'],
        timestamp = DateTime.parse(json['timestamp']),
        content = json['content'];
  Map<String, dynamic> toJson() {
    return {
      "sender_id": senderId,
      "timestamp": timestamp.toIso8601String(),
      "content": content,
    };
  }
}
