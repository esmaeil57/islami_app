import 'package:flutter/material.dart';
import 'package:islami_app/model/Radios.dart';
import 'package:provider/provider.dart';
import '../../../providers/settings_provider.dart';
import '../../utils/app_colors.dart';
import 'package:audioplayers/audioplayers.dart';

class RadioITem extends StatelessWidget {
  RadioModel radioModel;
  AudioPlayer audioPlayer;
  late SettingsProvider provider ;
  RadioITem({required this.radioModel, required this.audioPlayer, super.key});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(radioModel.name ?? '',
              style: TextStyle(color: provider.currentMode == ThemeMode.light ?
              AppColors.accent : AppColors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    await audioPlayer.play(UrlSource(radioModel.url??''));
                  },
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    size: 40,
                    color: provider.currentMode == ThemeMode.light ?
                    AppColors.primiary : AppColors.secondary,
                  )),
              IconButton(
                  onPressed: () {
                    audioPlayer.stop();
                  },
                  icon: Icon(
                    Icons.stop_circle_rounded,
                    size: 40,
                    color: provider.currentMode == ThemeMode.light ?
                    AppColors.primiary : AppColors.secondary,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
