import 'package:flutter/material.dart';
import 'screens/guest_home_screen.dart'; 
import 'screens/user_plant_manager.dart';   
import 'screens/splash_screen.dart';               
import 'screens/welcome_screen.dart';             

void main() {
  runApp(const EcoLeafApp());
}

class EcoLeafApp extends StatefulWidget {
  const EcoLeafApp({super.key});

  @override
  State<EcoLeafApp> createState() => _EcoLeafAppState();
}

class _EcoLeafAppState extends State<EcoLeafApp> {
  int _appState = 0; 

  void _handleLoginSuccess() {
    setState(() {
      _appState = 2; // Switches to User Screen
    });
  }

  void _handleLogout() {
    setState(() {
      _appState = 0; // Switches back to Splash/Welcome
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoLeaf',
      theme: ThemeData(primarySwatch: Colors.green, scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: _appState == 0
          ? SplashScreen(onLoginSuccess: _handleLoginSuccess)
          : _appState == 1
              ? GuestHomeScreen(onLoginSuccess: _handleLoginSuccess) 
              : UserPlantManager(onLogout: _handleLogout),
    );
  }
}