import 'package:dashboard_route_app/controllers/track/stops_controller.dart';
import 'package:get/get.dart';

import '../controllers/bus_controller.dart';
import '../controllers/custom_menu_controller.dart';
import '../controllers/map_box_controller.dart';
import '../controllers/routes_controller.dart';
import '../controllers/track/edit_controller.dart';
import '../controllers/track/tracks_controller.dart';
import '../controllers/track/view_controller.dart';

import '../controllers/tracking_controller.dart';
import '../controllers/users_controller.dart';
import '../screens/login/login_screen.dart';
import '../screens/main/main_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
        GetPage(
            name: MainScreen.routeName,
            page: () => const MainScreen(),
            binding: BindingsBuilder(() {
              // Tracks
              Get.put(StopsController());
              Get.put(TracksController());
              Get.put(UsersController());
              Get.put(BusController());
              // Get.put(RouteController());
              // Get.put(TrackingController());

              Get.put(EditController());
              Get.put(CustomMenuController());
              Get.put(ViewController());

              //  Users

              // Maps
              Get.put(CustomMapController());
            })),
      ];
}
