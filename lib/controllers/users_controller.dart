import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../dbHelper/mongo_db.dart';
import '../models/users.dart';

//TODO: mogno updateAdmin(mongo.ObjectID id, User a)

//TODO: mogno updateDriver(mongo.ObjectID id, User d)

//TODO: mogno updateMember(mongo.ObjectID id, User u)

enum UserType { admin, driver, member }

class UsersController extends GetxController {
  final usersState = UserType.member.obs;
  final fetchingMembers = FetchingState.getting.obs;
  final fetchingDrivers = FetchingState.getting.obs;
  final fetchingAdmins = FetchingState.getting.obs;
  final members = <User>[].obs;
  final admins = <User>[].obs;
  final drivers = <User>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    initiliazeUsers();
    super.onInit();
  }

  void initiliazeUsers() {
    fetchingMembers.value = FetchingState.getting;
    fetchingAdmins.value = FetchingState.getting;
    fetchingDrivers.value = FetchingState.getting;

    getAdminsFromDatabase();
    print('GET ADMINS');
    getDriversFromDatabase();
    getMembersFromDatabase();
  }

  void getAdminsFromDatabase() async {
    final value = await MongoDatabase.getAdmins();
    List<User> dAdmins = value.map((admin) => User.fromJson(admin)).toList();
    print('Emails  ${dAdmins[0].email}');
    admins.value = dAdmins;
    fetchingAdmins.value = FetchingState.done;
  }

  void getDriversFromDatabase() async {
    final value = await MongoDatabase.getDrivers();
    List<User> dDrivers = value.map((driver) => User.fromJson(driver)).toList();
    drivers.value = dDrivers;
    fetchingDrivers.value = FetchingState.done;
  }

  void getMembersFromDatabase() async {
    final value = await MongoDatabase.getMembers();
    List<User> dMembers = value.map((member) => User.fromJson(member)).toList();
    members.value = dMembers;
    fetchingMembers.value = FetchingState.done;
  }

  void copyMembersToClipboard() {
    final jsonList = members.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString))
        .then((v) => print('data Copied'));
  }

  void copyDriversToClipboard() {
    final jsonList = drivers.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString)).then((v) {
      if (kDebugMode) {
        print('data Copied');
      }
    });
  }

  void copyAdminsToClipboard() {
    final jsonList = admins.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString)).then((v) {
      if (kDebugMode) {
        print('data Copied');
      }
    });
  }

  List<String> get driverUsername =>
      drivers.map((driver) => driver.username).toList();

  int get blockedMembers {
    int count = 0;
    for (int i = 0; i < members.length; i++) {
      members[i].isBlocked == true ? count++ : null;
    }
    return count;
  }

  int get blockedAdmins {
    int count = 0;
    for (int i = 0; i < admins.length; i++) {
      admins[i].isBlocked == true ? count++ : null;
    }
    return count;
  }

  int get blockedDrivers {
    int count = 0;
    for (int i = 0; i < drivers.length; i++) {
      drivers[i].isBlocked == true ? count++ : null;
    }
    return count;
  }

  int get blocked {
    if (usersState.value == UserType.admin) {
      return blockedAdmins;
    } else if (usersState.value == UserType.driver) {
      return blockedDrivers;
    }
    return blockedMembers;
  }

  int get total {
    if (usersState.value == UserType.admin) {
      return admins.length;
    } else if (usersState.value == UserType.driver) {
      return drivers.length;
    }
    return members.length;
  }

  @override
  void onReady() {
    // initAuth();

    super.onReady();
  }

  void setUsersState(UserType value) {
    usersState.value = value;
  }

  // Driver FUnctions
  User? getUserByID(mongo.ObjectId id, UserType userType) {
    if (userType == UserType.driver) {
      int index = drivers.indexWhere((element) => element.id == id);
      return index > -1 ? drivers[index] : null;
    } else if (userType == UserType.member) {
      int index = members.indexWhere((element) => element.id == id);
      return index > -1 ? members[index] : null;
    } else {
      int index = admins.indexWhere((element) => element.id == id);
      return index > -1 ? admins[index] : null;
    }
  }

  int getIndexByID(mongo.ObjectId id, UserType userType) {
    if (userType == UserType.driver) {
      return drivers.indexWhere((element) => element.id == id);
    } else if (userType == UserType.member) {
      return members.indexWhere((element) => element.id == id);
    } else {
      return admins.indexWhere((element) => element.id == id);
    }
  }

  Future<bool> deleteUser(
      BuildContext context, int index, UserType userType) async {
    if (userType == UserType.driver) {
      final result = await MongoDatabase.deleteDriver(drivers[index].id);
      if (result) {
        drivers.removeAt(index);
      }
      return result;
    } else if (userType == UserType.member) {
      final result = await MongoDatabase.deleteMember(members[index].id);
      if (result) {
        members.removeAt(index);
      }
      return result;
    } else {
      final result = await MongoDatabase.deleteAdmin(admins[index].id);
      if (result) {
        admins.removeAt(index);
      }
      return result;
    }
  }
}
