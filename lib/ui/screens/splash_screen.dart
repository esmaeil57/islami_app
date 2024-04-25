import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import 'home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "splash" ;
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay transition to main screen for 1 seconds
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }
late SettingsProvider provider ;
  @override
  Widget build(BuildContext context){
    provider = Provider.of(context) ;
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Consumer <SettingsProvider>(
        builder: (context, provider, child) {
          return Center(
            child: Image.asset(
              provider.currentMode == ThemeMode.light
                  ? AppAssets.lightSplash
                  : AppAssets.darkSplash,
            ),
          );
        },
      ),
    );
  } }