import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../models/users.dart';
import '../sockets/admins_api.dart';
import '../sockets/drivers_api.dart';
import '../sockets/members_api.dart';
import 'fetching.dart';

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

  final fetching = FetchingState.getting.obs;
  final _membersSocketStream = StreamController<List<User>>.broadcast();
  final _driversSocketStream = StreamController<List<User>>.broadcast();
  final _adminsSocketStream = StreamController<List<User>>.broadcast();
  final membersApi = MembersSocketApi();
  final driversApi = DriversSocketApi();
  final adminsApi = AdminsSocketApi();

  @override
  void onInit() {
    super.onInit();
    _loadAdmins();
    _loadDrivers();
    _loadMembers();
  }

  void _loadMembers() {
    membersApi.stream.listen((data) {
      fetchingMembers.value = FetchingState.getting;
      members.clear();
      members.addAll(data);
      fetchingMembers.value = FetchingState.done;

      // add the data to the _socketStream for other listeners
      _membersSocketStream.add(data);
    });
    membersApi.send(json.encode({'action': 'LOAD'}));
  }

  void _loadDrivers() {
    driversApi.stream.listen((data) {
      fetchingDrivers.value = FetchingState.getting;
      drivers.clear();
      drivers.addAll(data);
      fetchingDrivers.value = FetchingState.done;

      // add the data to the _socketStream for other listeners
      _driversSocketStream.add(data);
    });
    driversApi.send(json.encode({'action': 'LOAD'}));
  }

  void _loadAdmins() {
    adminsApi.stream.listen((data) {
      fetchingAdmins.value = FetchingState.getting;
      admins.clear();
      admins.addAll(data);
      fetchingAdmins.value = FetchingState.done;

      // add the data to the _socketStream for other listeners
      _adminsSocketStream.add(data);
    });
    adminsApi.send(json.encode({'action': 'LOAD'}));
  }

  void copyMembersToClipboard() {
    final jsonList = members.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString)).then((v) {
      if (kDebugMode) {
        print('data Copied');
      }
    });
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
      driversApi.send(json.encode({
        'action': 'DELETE',
        'payload': drivers[index].id,
      }));
      return true;
    } else if (userType == UserType.member) {
      membersApi.send(json.encode({
        'action': 'DELETE',
        'payload': members[index].id,
      }));
      return true;
    } else {
      adminsApi.send(json.encode({
        'action': 'DELETE',
        'payload': admins[index].id,
      }));
      return true;
    }
  }

  Future<bool> deleteUsers(
      BuildContext context, List<int> indexes, UserType userType) async {
    print('hoo');
    final List<mongo.ObjectId> toDelete = [];
    if (userType == UserType.driver) {
      for (int i = 0; i < indexes.length; i++) {
        toDelete.add(drivers[indexes[i]].id);
      }
      driversApi.send(json.encode({
        'action': 'DELETE_MULTIPLE',
        'payload': toDelete,
      }));
      return true;
    } else if (userType == UserType.member) {
      for (int i = 0; i < indexes.length; i++) {
        toDelete.add(members[indexes[i]].id);
      }
      membersApi.send(json.encode({
        'action': 'DELETE_MULTIPLE',
        'payload': toDelete,
      }));
      return true;
    } else {
      for (int i = 0; i < indexes.length; i++) {
        toDelete.add(admins[indexes[i]].id);
      }
      adminsApi.send(json.encode({
        'action': 'DELETE_MULTIPLE',
        'payload': toDelete,
      }));
      return true;
    }
  }

  Future<bool> addUser(User user, UserType userType) async {
    print(user.toJson());
    if (userType == UserType.driver) {
      driversApi.send(json.encode({
        'action': 'ADD',
        'payload': user.toJson(),
      }));
      return true;
    } else if (userType == UserType.member) {
      membersApi.send(json.encode({
        'action': 'ADD',
        'payload': user.toJson(),
      }));
      return true;
    } else {
      adminsApi.send(json.encode({
        'action': 'ADD',
        'payload': user.toJson(),
      }));
      return true;
    }
  }

  Future<bool> updateUser(User user, UserType userType) async {
    print(user.toJson());
    if (userType == UserType.driver) {
      driversApi.send(json.encode({
        'action': 'UPDATE',
        'payload': user.toJson(),
      }));
      return true;
    } else if (userType == UserType.member) {
      membersApi.send(json.encode({
        'action': 'UPDATE',
        'payload': user.toJson(),
      }));
      return true;
    } else {
      adminsApi.send(json.encode({
        'action': 'UPDATE',
        'payload': user.toJson(),
      }));
      return true;
    }
  }
}
