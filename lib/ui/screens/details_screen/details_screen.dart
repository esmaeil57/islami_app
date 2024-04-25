import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/model/details_screen_args.dart';
import 'package:islami_app/providers/settings_provider.dart';
import 'package:islami_app/ui/utils/app_assets.dart';
import 'package:islami_app/ui/utils/app_colors.dart';
import 'package:islami_app/ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = "details screen";

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String fileContent = "";
late SettingsProvider provider ;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    var args = ModalRoute.of(context)!.settings.arguments as DetailsScreenArgs;
    if(fileContent.isEmpty) {
      readFile(args.fileName, args.isQuranFile);
    }

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(provider.currentMode == ThemeMode.light ?
          AppAssets.background : AppAssets.backgroundDark), fit: BoxFit.fill)
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.transparent,
          title: Text(args.screenTitle,
            style: provider.currentMode == ThemeMode.light ?
            AppTheme.appBarTitleTextStyle : AppTheme.appBarTitleTextStyle.copyWith(color: Colors.white) ,),
        ),
        body:fileContent.isNotEmpty ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(fileContent,textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: provider.currentMode == ThemeMode.light ?
                AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal) :
                AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal),),
            ))
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

   readFile(String fileName, bool isQuranFile) {
    Future<String> futureFileContent = rootBundle.loadString(isQuranFile?
        "assets/files/$fileName" :   "assets/files/ahadeth/$fileName"
    );
    futureFileContent.then((file) {
      if(!isQuranFile){
        fileContent = file;
        setState(() {});
        return ;
      }
      List<String> fileLines = file.split("\n");
      for(int i = 0; i< fileLines.length; i++){
        fileLines[i] += "(${i+1})";
      }
      fileContent = fileLines.join();
      setState(() {});
    });
  }
}
