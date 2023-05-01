import 'package:dashboard_route_app/models/message/chat_member.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'chat_collection_type.dart';
import 'last_message.dart';

class ChatCollection {
  mongo.ObjectId id;
  ChatCollectionType type;
  String name;
  List<ChatMember> members;
  LastMessage lastMessage;
  int unreadCount;

  ChatCollection({
    required this.id,
    required this.type,
    required this.name,
    required this.members,
    required this.lastMessage,
    required this.unreadCount,
  });

  ChatCollection.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        type = stringToChatCollectionType(json["type"]),
        name = json["name"],
        members = List<ChatMember>.from(
            json["members"].map((m) => ChatMember.fromJson(m))),
        lastMessage = LastMessage.fromJson(json["last_message"]),
        unreadCount = json["unread_count"];

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "type": chatCollectionTypeToString(type),
      "name": name,
      "members": members.map((m) => m.toJson()).toList(),
      "last_message": lastMessage.toJson(),
      "unread_count": unreadCount,
    };
  }
}
