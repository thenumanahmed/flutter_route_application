import 'package:dashboard_route_app/controllers/users_controller.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class User {
  mongo.ObjectId id;
  String email;
  String username;
  String password;
  String phoneNo;
  bool isBlocked;
  User({
    required this.id,
    required this.username,
    required this.password,
    this.phoneNo = '',
    this.email = '',
    this.isBlocked = false,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'].runtimeType == mongo.ObjectId
            ? json['_id'] as mongo.ObjectId
            : mongo.ObjectId.fromHexString(json['_id']),
        email = json['email'] as String,
        username = json['username'] as String,
        password = json['password'] as String,
        phoneNo = json['phone_no'] as String,
        isBlocked = json['is_blocked'] as bool;

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "username": username,
      "password": password,
      "phone_no": phoneNo,
      "is_blocked": isBlocked,
    };
  }

  static UserType stringToUserType(String s) {
    if (s == 'Admin') {
      return UserType.admin;
    } else if (s == 'Driver') {
      return UserType.driver;
    } else {
      return UserType.member;
    }
  }

  static String userTypeToString(UserType ut) {
    if (ut == UserType.admin) {
      return 'Admin';
    } else if (ut == UserType.driver) {
      return 'Driver';
    } else {
      return 'Member';
    }
  }
}
