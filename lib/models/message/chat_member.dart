import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ChatMember {
  mongo.ObjectId userId;
  String email;
  ChatMember({
    required this.userId,
    required this.email,
  });

  ChatMember.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        email = json['email'];
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "email": email,
    };
  }
}
