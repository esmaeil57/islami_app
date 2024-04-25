import 'package:flutter/material.dart';
import 'package:islami_app/providers/settings_provider.dart';
import 'package:islami_app/ui/utils/app_assets.dart';
import 'package:islami_app/ui/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int _counter = 0;

  double _rotationAngle = 0.0 ;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _rotationAngle += 1/33;
    });
  }
  late SettingsProvider provider ;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context) ;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 77),
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppAssets.headSebha),
                      alignment: Alignment.topCenter),
                ),
                child:AnimatedRotation(
                  turns: _rotationAngle,
                  duration: const Duration(milliseconds: 500),
                  child: InkWell(
                    onTap: _incrementCounter,
                    child: Image.asset(AppAssets.bodySebha,
                      alignment: Alignment.bottomCenter,),
                  ),
                ),
              ),
               Text(
                "عدد التسبيحات  ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                    color: provider.currentMode == ThemeMode.light ? AppColors.accent : AppColors.white),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.secondary,
                ),
                child: Text(
                  '$_counter',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.primiary,
                ),
                child: InkWell(
                  onTap: _incrementCounter,
                  borderRadius: BorderRadius.circular(20),
                  child: const Text(
                    "سبحان الله ",
                    style: TextStyle(fontSize: 25, color: AppColors.accent),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
