// This class defines a GetX middleware for route redirection. 
// - `priority` determines the execution order of the middleware.
// - `redirect` checks if the user has completed onboarding by reading shared preferences. 
//   If onboarding is completed ("1"), it redirects the user to the login page; 
//   otherwise, it allows the user to continue to the requested route.


/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoinex/core/constant/routesname.dart';
import 'package:phoinex/core/services/services.dart';

class MyMiddleWare extends GetMiddleware{

  @override
  int? get priority => 1;

  MyServices myServices = Get.find();
  @override
  RouteSettings? redirect(String? route){
    if(myServices.sharedPreferences.getString("onboarding") == "1"){
      return RouteSettings(name: Approute.login) ;
    }
  
    
  }
} */