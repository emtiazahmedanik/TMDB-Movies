import 'package:flutter/material.dart';
import 'package:tmdbmovies/ui/screens/color.dart';
import 'package:tmdbmovies/ui/screens/home_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;


  final List<Widget> _screens = const [
    HomeScreen(),
    HomeScreen(),
    HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          backgroundColor: AppColors.deepBlue,
          indicatorColor: Colors.blue,
          onDestinationSelected: (index){
          setState(() {
            _selectedIndex = index;
          });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search_outlined), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.bookmark_add_outlined), label: 'Watch list'),
          ]
      ),
    );
  }
}
