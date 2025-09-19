// This code defines all the app routes using GetX's GetPage. 
// Each route maps a route name to its corresponding screen widget. 
// Middlewares like `MyMiddleWare` can be applied to specific routes (e.g., for onboarding checks). 
// The routes cover authentication, onboarding, home, journey planning, landmarks, and saved plans screens.



/* 
 
 
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoinex/core/constant/routesname.dart';
import 'package:phoinex/core/middleware/mymiddleware.dart';
import 'package:phoinex/test.dart';
import 'package:phoinex/view/screen/Yourjourney/yourjourney.dart';
import 'package:phoinex/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:phoinex/view/screen/auth/login.dart';
import 'package:phoinex/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:phoinex/view/screen/auth/signup.dart';
import 'package:phoinex/view/screen/auth/forgetpassword/succesresetpassword.dart';
import 'package:phoinex/view/screen/auth/success_signup.dart';
import 'package:phoinex/view/screen/auth/forgetpassword/verfiycode.dart';
import 'package:phoinex/view/screen/auth/verfiycodesignup.dart';
import 'package:phoinex/view/screen/home/home.dart';
import 'package:phoinex/view/screen/landmark/eventchoose.dart';
import 'package:phoinex/view/screen/landmark/hotelchoose.dart';
import 'package:phoinex/view/screen/landmark/landmarkchoose.dart';
import 'package:phoinex/view/screen/landmark/resturentchoose.dart';
import 'package:phoinex/view/screen/languagge.dart';
import 'package:phoinex/view/screen/onboarding.dart';
import 'package:phoinex/view/screen/planjoureny/planjoureny.dart';
import 'package:phoinex/view/screen/savedplan/savedplan.dart';

List<GetPage<dynamic>>? routes = [
  //auth
  GetPage(name: "/", page: () =>Language(), middlewares: [
    MyMiddleWare()
  ]),
 // GetPage(name: "/", page: () =>Test()),
  GetPage(name: Approute.login, page: () =>Login()),
  GetPage(name: Approute.signup, page: () =>Signup()),
  GetPage(name: Approute.forgetpassword, page: () =>ForgetPassword()),
  GetPage(name: Approute.verficode, page: () =>VerfiyCode()),
  GetPage(name: Approute.resetpassword, page: () =>ResetPassword()),
  GetPage(name: Approute.successsignUp, page: () =>SuccessSignUp()),
  GetPage(name: Approute.successresetpassword, page: () =>SuccesResetPassword()),
  GetPage(name: Approute.verfiycodesignup, page: () =>VerfiyCodeSignUp()),

 GetPage(name: Approute.home, page: () => HomeView()),
  GetPage(name: Approute.planjoreny, page: () => PlanJoureny()),
  GetPage(name: Approute.landmarkschoose, page: () => LandmarkChoose()),
  GetPage(name: Approute.resturantChoose, page: () => ResturantChoose()),
  GetPage(name: Approute.hotelchoose, page: () => HotelChoose()),
  GetPage(name: Approute.eventchoose, page: () => EventChoose()),
  GetPage(name: Approute.yourjourney, page: () => Yourjourney()),
  GetPage(name: Approute.savedplans, page: () => SavedPlans()),

  // onboarding
  GetPage(name: Approute.onBoarding, page: () =>OnBoarding()),
];

*/