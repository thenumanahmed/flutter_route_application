// ignore_for_file: constant_identifier_names
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SocketApi {
  static late String url;

  static Future<void> updateUrl() async {
    String domain = 'http://url.uetroute.com';
    try {
      http.Response response = await http.get(Uri.parse(domain));
      url = response.body;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
    }
  }

  static String get kBusesWsUrl => 'ws://$url/$_BUSES_WEBSOCKET';
  static String get kAdminsWsUrl => 'ws://$url/$_ADMINS_WEBSOCKET';
  static String get kDriversWsUrl => 'ws://$url/$_DRIVERS_WEBSOCKET';
  static String get kMembersWsUrl => 'ws://$url/$_MEMBERS_WEBSOCKET';
  static String get kTracksWsUrl => 'ws://$url/$_TRACKS_WEBSOCKET';
  static String get kStopsWsUrl => 'ws://$url/$_STOPS_WEBSOCKET';
  static String get kPathsWsUrl => 'ws://$url/$_PATHS_WEBSOCKET';
  static String get kRoutesWsUrl => 'ws://$url/$_ROUTES_WEBSOCKET';
  static String get kTrackingsWsUrl => 'ws://$url/$_TRACKING_WEBSOCKET';

  static const _BUSES_WEBSOCKET = "buses-ws/";
  static const _ADMINS_WEBSOCKET = "admins-ws/";
  static const _DRIVERS_WEBSOCKET = "drivers-ws/";
  static const _MEMBERS_WEBSOCKET = "members-ws/";
  static const _TRACKS_WEBSOCKET = "tracks-ws/";
  static const _ROUTES_WEBSOCKET = "routes-ws/";
  static const _TRACKING_WEBSOCKET = "tracking-ws/";
  static const _STOPS_WEBSOCKET = "stops-ws/";
  static const _PATHS_WEBSOCKET = "paths-ws/";
}









  
// const kServer = 'localhost';
// const kPort = 9018;
// const url = '22552937f6b01f852a5c37d13ec0ba1a.loophole.site';
// const url = 'server.uetroute.com';



// const kBusesWsUrl = 'ws://$kServer:$kPort/$BUSES_WEBSOCKET';
// const kAdminsWsUrl = 'ws://$kServer:$kPort/$ADMINS_WEBSOCKET';
// const kDriversWsUrl = 'ws://$kServer:$kPort/$DRIVERS_WEBSOCKET';
// const kMembersWsUrl = 'ws://$kServer:$kPort/$MEMBERS_WEBSOCKET';
// const kTracksWsUrl = 'ws://$kServer:$kPort/$TRACKS_WEBSOCKET';
// const kStopsWsUrl = 'ws://$kServer:$kPort/$STOPS_WEBSOCKET';
// const kPathsWsUrl = 'ws://$kServer:$kPort/$PATHS_WEBSOCKET';
// const kRoutesWsUrl = 'ws://$kServer:$kPort/$ROUTES_WEBSOCKET';
// const kTrackingsWsUrl = 'ws://$kServer:$kPort/$TRACKING_WEBSOCKET';