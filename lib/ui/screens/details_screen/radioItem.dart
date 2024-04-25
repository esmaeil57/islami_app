import 'package:flutter/material.dart';
import 'package:islami_sat_c9/model/Radios.dart';
import '../../utils/app_colors.dart';
import 'package:audioplayers/audioplayers.dart';

class RadioITem extends StatelessWidget {
  RadioModel radioModel;
  AudioPlayer audioPlayer;
  RadioITem({required this.radioModel, required this.audioPlayer, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(radioModel.name ?? '',
              style: const TextStyle(color: AppColors.accent)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    await audioPlayer.play(UrlSource(radioModel.url??''));
                  },
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    size: 40,
                    color: AppColors.primiary,
                  )),
              IconButton(
                  onPressed: () {
                    audioPlayer.stop();
                  },
                  icon: const Icon(
                    Icons.stop_circle_rounded,
                    size: 40,
                    color: AppColors.primiary,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
