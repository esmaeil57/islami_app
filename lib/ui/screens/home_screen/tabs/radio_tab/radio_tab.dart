import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/ui/screens/details_screen/radioItem.dart';
import 'package:islami_app/ui/utils/app_assets.dart';
import 'package:islami_app/ui/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../model/Radios.dart';
import 'package:http/http.dart' as http;
import '../../../../../providers/settings_provider.dart';

class RadioTab extends StatelessWidget {
  final player = AudioPlayer();
  late SettingsProvider provider ;
  RadioTab({super.key});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context) ;
    return FutureBuilder(
        future: getRadios(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var radios = snapshot.data?.radios ?? [];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.radioImage),
                 Text("إذاعة القرآن الكريم",
                    style:
                    TextStyle(color: provider.currentMode == ThemeMode.light ?
                    AppColors.accent : AppColors.white),),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  child: ListView.builder(
                    physics: const PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => RadioITem(
                      radioModel: radios[index],
                      audioPlayer: player,
                    ),
                    itemCount: radios.length,
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Future<Radios> getRadios() async {
    var url = Uri.parse("https://mp3quran.net/api/v3/radios");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      return Radios.fromJson(json);
    } else {
      throw Exception('Faild to load Radios');
    }
  }
}
