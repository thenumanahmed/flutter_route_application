import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../models/users.dart';

enum UserType { admin, driver, member }

class UsersController extends GetxController {
  final usersState = UserType.member.obs;

  final members = <User>[...kMembers].obs;
  final admins = <User>[...kAdmins].obs;
  final drivers = <User>[...kDrivers].obs;

  void copyMembersToClipboard() {
    final jsonList = members.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString))
        .then((v) => print('data Copied'));
  }

  void copyDriversToClipboard() {
    final jsonList = drivers.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString))
        .then((v) => print('data Copied'));
  }

  void copyAdminsToClipboard() {
    final jsonList = admins.map((track) => track.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    Clipboard.setData(ClipboardData(text: jsonString))
        .then((v) => print('data Copied'));
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

  void deleteUser(int index, UserType userType) {
    if (kDebugMode) {
      print('Removed  {members[tIndex].name}');
    }
    if (userType == UserType.driver) {
      drivers.removeAt(index);
    } else if (userType == UserType.member) {
      members.removeAt(index);
    } else {
      admins.removeAt(index);
    }
  }
}

final kAdmins = <User>[
  User(id: mongo.ObjectId(), username: 'admin1', password: 'a001'),
  User(id: mongo.ObjectId(), username: 'admin2', password: 'a002'),
  User(id: mongo.ObjectId(), username: 'admin3', password: 'a003'),
  User(id: mongo.ObjectId(), username: 'admin4', password: 'a004'),
  User(id: mongo.ObjectId(), username: 'admin5', password: 'a005'),
  User(id: mongo.ObjectId(), username: 'admin6', password: 'a006'),
];

final kDrivers = <User>[
  User(id: mongo.ObjectId(), username: 'driver1', password: 'd001'),
  User(id: mongo.ObjectId(), username: 'driver2', password: 'd002'),
  User(id: mongo.ObjectId(), username: 'driver3', password: 'd003'),
  User(id: mongo.ObjectId(), username: 'driver4', password: 'd004'),
  User(id: mongo.ObjectId(), username: 'driver5', password: 'd005'),
  User(id: mongo.ObjectId(), username: 'driver6', password: 'd006'),
  User(id: mongo.ObjectId(), username: 'driver7', password: 'd007'),
];

final kMembers = <User>[
  User(
    id: mongo.ObjectId(),
    username: 'aliha',
    password: 'u001',
    email: '2021se1',
  ),
  User(
    id: mongo.ObjectId(),
    username: 'kokab',
    password: 'u003',
    email: '2021se3',
  ),
  User(
    id: mongo.ObjectId(),
    username: 'salman',
    password: 'u004',
    email: '2021se4',
  ),
  User(
    id: mongo.ObjectId(),
    username: 'aiza',
    password: 'u005',
    email: '2021se5',
  ),
  User(
      id: mongo.ObjectId(),
      username: 'hashim',
      password: 'u006',
      email: '2021se6'),
  User(
      id: mongo.ObjectId(),
      username: 'husnain',
      password: 'u007',
      email: '2021se7'),
  User(
      id: mongo.ObjectId(),
      username: 'armab',
      password: 'u009',
      email: '2021se9'),
  User(
      id: mongo.ObjectId(),
      username: 'Emaan',
      password: 'u010',
      email: '2021se10'),
  User(
      id: mongo.ObjectId(),
      username: 'areeba',
      password: 'u011',
      email: '2021se1'),
  User(
      id: mongo.ObjectId(),
      username: 'sehrish',
      password: 'u012',
      email: '2021se12'),
  User(
      id: mongo.ObjectId(),
      username: 'areej',
      password: 'u013',
      email: '2021se13'),
  User(
      id: mongo.ObjectId(),
      username: 'labeeb',
      password: 'u015',
      email: '2021se15'),
  User(
      id: mongo.ObjectId(),
      username: 'gazanfar',
      password: 'u016',
      email: '2021se16'),
  User(
      id: mongo.ObjectId(),
      username: 'areeba',
      password: 'u017',
      email: '2021se17'),
  User(
      id: mongo.ObjectId(),
      username: 'afaq',
      password: 'u018',
      email: '2021se18'),
  User(
      id: mongo.ObjectId(),
      username: 'hira',
      password: 'u019',
      email: '2021se19'),
  User(
      id: mongo.ObjectId(),
      username: 'waqas',
      password: 'u021',
      email: '2021se21'),
  User(
      id: mongo.ObjectId(),
      username: 'haseeb',
      password: 'u022',
      email: '2021se22'),
  User(
      id: mongo.ObjectId(),
      username: 'zain',
      password: 'u023',
      email: '2021se23'),
  User(
      id: mongo.ObjectId(),
      username: 'nouman',
      password: 'u024',
      email: '2021se24'),
  User(
      id: mongo.ObjectId(),
      username: 'Kausar',
      password: 'u025',
      email: '2021se25'),
  User(
      id: mongo.ObjectId(),
      username: 'Ume',
      password: 'u027',
      email: '2021se27'),
  User(
      id: mongo.ObjectId(),
      username: 'Umer',
      password: 'u028',
      email: '2021se28'),
  User(
      id: mongo.ObjectId(),
      username: 'Zara',
      password: 'u029',
      email: '2021se29'),
  User(
      id: mongo.ObjectId(),
      username: 'Nimra',
      password: 'u030',
      email: '2021se30'),
  User(
      id: mongo.ObjectId(),
      username: 'Moeez',
      password: 'u031',
      email: '2021se31'),
  User(
      id: mongo.ObjectId(),
      username: 'Saad',
      password: 'u032',
      email: '2021se32'),
  User(
      id: mongo.ObjectId(),
      username: 'Samiha',
      password: 'u033',
      email: '2021se33'),
  User(
      id: mongo.ObjectId(),
      username: 'Surooj',
      password: 'u034',
      email: '2021se34'),
  User(
      id: mongo.ObjectId(),
      username: 'Mohsina',
      password: 'u035',
      email: '2021se35'),
  User(
      id: mongo.ObjectId(),
      username: 'Hammad',
      password: 'u036',
      email: '2021se36'),
  User(
      id: mongo.ObjectId(),
      username: 'Laiba',
      password: 'u037',
      email: '2021se37'),
  User(
      id: mongo.ObjectId(),
      username: 'wali',
      password: 'u039',
      email: '2021se39'),
  User(
      id: mongo.ObjectId(),
      username: 'aysha',
      password: 'u040',
      email: '2021se40'),
  User(
      id: mongo.ObjectId(),
      username: 'usama',
      password: 'u041',
      email: '2021se41'),
  User(
      id: mongo.ObjectId(),
      username: 'abdul-Rehman',
      password: 'u043',
      email: '2021se43'),
  User(
      id: mongo.ObjectId(),
      username: 'haroon',
      password: 'u044',
      email: '2021se44'),
  User(
      id: mongo.ObjectId(),
      username: 'rehan',
      password: 'u046',
      email: '2021se46'),
  User(
      id: mongo.ObjectId(),
      username: 'rizwanullah',
      password: 'u047',
      email: '2021se47'),
  User(
      id: mongo.ObjectId(),
      username: 'sadaam',
      password: 'u048',
      email: '2021se48'),
  User(
      id: mongo.ObjectId(),
      username: 'nouman',
      password: 'u049',
      email: '2021se49'),
  User(
      id: mongo.ObjectId(),
      username: 'samsoor',
      password: 'u050',
      email: '2021se50'),
  User(
      id: mongo.ObjectId(),
      username: 'khadija',
      password: 'u053',
      email: '2021se53'),
  User(
      id: mongo.ObjectId(),
      username: 'faqeed',
      password: 'u054',
      email: '2021se54'),
  User(
      id: mongo.ObjectId(),
      username: 'sameer',
      password: 'u055',
      email: '2021se55'),
  User(
      id: mongo.ObjectId(),
      username: 'farjad',
      password: 'u056',
      email: '2021se56'),
];
