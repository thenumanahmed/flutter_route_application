import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './bindings/initial_bindings.dart';
import './routes/routes.dart';
import './configs/themes/app_dark_theme.dart';
import './configs/themes/app_light_theme.dart';
// import './dbHelper/mongo_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get x Controller initialization

  InitialBindings().dependencies();
  await dotenv.load(fileName: "assets/config/.env");

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme().buildLigtTheme(),
      darkTheme: DarkTheme().buildDarkTheme(),
      getPages: AppRoutes.routes(),
    );
  }
}
