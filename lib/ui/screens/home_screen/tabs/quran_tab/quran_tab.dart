import 'package:flutter/material.dart';
import 'package:islami_app/model/details_screen_args.dart';
import 'package:islami_app/providers/settings_provider.dart';
import 'package:islami_app/ui/screens/details_screen/details_screen.dart';
import 'package:islami_app/ui/utils/app_assets.dart';
import 'package:islami_app/ui/utils/app_colors.dart';
import 'package:islami_app/ui/utils/app_theme.dart';
import 'package:islami_app/ui/utils/constants.dart';
import 'package:provider/provider.dart';

class QuranTab extends StatelessWidget {
  late SettingsProvider provider ;
   QuranTab({super.key});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context) ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 3,
            child: Image.asset(AppAssets.quranTabLogo)),
         Divider(color:  provider.currentMode == ThemeMode.light ? AppColors.primiary : AppColors.secondary ,),
         Text("Sura Name",textAlign: TextAlign.center ,
          style: provider.currentMode == ThemeMode.light ?  AppTheme.lightTheme.textTheme.bodyMedium :
         AppTheme.darkTheme.textTheme.bodyMedium),
        Divider(color:  provider.currentMode == ThemeMode.light ? AppColors.primiary : AppColors.secondary ,),
        Expanded(flex: 7,
         child: ListView.separated(
             itemCount: Constants.suraNames.length,
              separatorBuilder: (__, _){
               return  Divider(thickness: 3,
                 color:  provider.currentMode == ThemeMode.light ? AppColors.primiary : AppColors.secondary ,);
              },
             itemBuilder: (context, index){
               return InkWell(
                 onTap: (){
                   Navigator.pushNamed(context, DetailsScreen.routeName,
                    arguments: DetailsScreenArgs(fileName: "${index+1}.txt",
                        screenTitle: Constants.suraNames[index], isQuranFile: true));
                 },
                 child: Text(Constants.suraNames[index],
                   textAlign: TextAlign.center,
                   style: provider.currentMode == ThemeMode.light ?
                   AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal) :
                   AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal),),
               );
             }),),
      ],
    );
  }
}
