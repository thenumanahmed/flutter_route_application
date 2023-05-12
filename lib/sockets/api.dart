// ignore_for_file: constant_identifier_names

const kServer = 'localhost';
const kPort = 7007;

const BUSES_WEBSOCKET = "buses-ws/";
const ADMINS_WEBSOCKET = "admins-ws/";
const DRIVERS_WEBSOCKET = "drivers-ws/";
const MEMBERS_WEBSOCKET = "members-ws/";
const TRACKS_WEBSOCKET = "tracks-ws/";
const ROUTES_WEBSOCKET = "routes-ws/";
const TRACKING_WEBSOCKET = "tracking-ws/";
const STOPS_WEBSOCKET = "stops-ws/";

const kBusesWsUrl = 'ws://$kServer:$kPort/$BUSES_WEBSOCKET';
const kAdminsWsUrl = 'ws://$kServer:$kPort/$ADMINS_WEBSOCKET';
const kDriversWsUrl = 'ws://$kServer:$kPort/$DRIVERS_WEBSOCKET';
const kMembersWsUrl = 'ws://$kServer:$kPort/$MEMBERS_WEBSOCKET';
const kTracksWsUrl = 'ws://$kServer:$kPort/$TRACKS_WEBSOCKET';
const kStopsWsUrl = 'ws://$kServer:$kPort/$STOPS_WEBSOCKET';
const kRoutesWsUrl = 'ws://$kServer:$kPort/$ROUTES_WEBSOCKET';
const kTrackingsWsUrl = 'ws://$kServer:$kPort/$TRACKING_WEBSOCKET';
