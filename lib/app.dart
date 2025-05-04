import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tmdbmovies/controllerBinder.dart';
import 'package:tmdbmovies/ui/screens/color.dart';
import 'package:tmdbmovies/ui/screens/main_bottom_nav_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TMDB Movies',
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        colorSchemeSeed: AppColors.deepBlue,
        navigationBarTheme: buildNavigationBarThemeData()
      ),
      home: const MainBottomNavScreen(),
    );
  }

  NavigationBarThemeData buildNavigationBarThemeData() {
    return NavigationBarThemeData(
        labelTextStyle:MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(color: Colors.blue);
          }
          return const TextStyle(color: Colors.white70);
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: Colors.white);
          }
          return const IconThemeData(color: Colors.white70);
        }),
      );
  }
}
