import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../model/details_screen_args.dart';
import '../../../../../providers/settings_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_theme.dart';
import '../../../details_screen/details_screen.dart';

class AhadethTab extends StatelessWidget {

   List<String> ahadethNames = List.generate(50, (index) => " ${index+1}الحديث رقم ");
   late SettingsProvider provider ;

  AhadethTab({super.key});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context) ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 3,
            child: Image.asset(AppAssets.ahadethTabLogo)),
        Divider(thickness: 3,
          color: provider.currentMode == ThemeMode.light ? AppColors.primiary : AppColors.secondary,),
        Text("Hadeth Name",textAlign: TextAlign.center ,
          style: provider.currentMode == ThemeMode.light ?  AppTheme.lightTheme.textTheme.bodyMedium :
          AppTheme.darkTheme.textTheme.bodyMedium,),
        Divider(thickness: 3,
          color:  provider.currentMode == ThemeMode.light ? AppColors.primiary : AppColors.secondary ,),
        Expanded(flex: 7,
          child: ListView.separated(
              itemCount: ahadethNames.length,
              separatorBuilder: (__, _){
                return  Divider(thickness: 3,
                  color: provider.currentMode == ThemeMode.light ? AppColors.primiary : AppColors.secondary,);
              },
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, DetailsScreen.routeName,
                        arguments: DetailsScreenArgs(fileName: "h${index+1}.txt",
                            screenTitle: ahadethNames[index], isQuranFile: false));
                  },
                  child: Text(ahadethNames[index],
                    textDirection: TextDirection.ltr,
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
