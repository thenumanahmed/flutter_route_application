import 'package:mongo_dart/mongo_dart.dart' as mongo;

class Message {
  mongo.ObjectId id;
  mongo.ObjectId senderId;
  mongo.ObjectId chatId;
  DateTime timestamp;
  String content;
  Message(
      {required this.id,
      required this.senderId,
      required this.chatId,
      required this.timestamp,
      required this.content});

  Message.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        senderId = json['sender_id'],
        chatId = json['chat_id'],
        timestamp = DateTime.parse(json['timestamp']),
        content = json['content'];

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "sender_id": senderId,
      "chat_id": chatId,
      "timestamp": timestamp.toIso8601String(),
      "content": content,
    };
  }
}
