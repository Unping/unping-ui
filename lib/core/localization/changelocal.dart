
// This GetX controller manages the app's localization and theme. 
// - `language` stores the current locale.
// - `appTheme` stores the current theme based on the selected language.
// - `ChangeLang(String langcode)` changes the app language and theme, 
//    saves the choice in shared preferences, updates the locale, and applies the theme.
// - `onInit()` initializes the controller by loading the saved language from shared preferences, 
//    or defaults to the device's language, and sets the appropriate theme.

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoinex/core/constant/apptheme.dart';
import 'package:phoinex/core/services/services.dart';

class LocalConroller extends GetxController{

  Locale? language;

  MyServices myServices = Get.find();

  ThemeData appTheme  = themeEnglish; // متغير  للتحكم بالخط بناء على ال
  ChangeLang(String langcode){
   Locale locale = Locale(langcode);
   myServices.sharedPreferences.setString("lang", langcode);
     
     //اذا الشخص اختار اللغة العربية اعطي التطبيق themearabic والا themeenglish
     appTheme = langcode == "ar" ? themeArabic : themeEnglish; 
     Get.changeTheme(appTheme);


   Get.updateLocale(locale);

  }
  @override
  void onInit() {
    super.onInit();
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang") ;
    if(sharedPrefLang == "ar"){
      language = const Locale("ar");
      appTheme = themeArabic;
    }
    else if(sharedPrefLang == "en"){
      language =  const Locale("en");
      appTheme = themeEnglish;
    }
  else{
    language = Locale(Get.deviceLocale!.languageCode) ;

    appTheme=themeEnglish;
  }  
  }
 
}
*/



