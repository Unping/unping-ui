 // This function shows a confirmation dialog when the user tries to exit the app. 
// It uses GetX's defaultDialog with two actions: 
// - "Confirm" → closes the application using exit(0) 
// - "Cancel" → dismisses the dialog and keeps the user inside the app.

 
 
 /* import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phoinex/core/constant/color.dart';


alertExitApp(){
    return Get.defaultDialog(
      backgroundColor: Appcolor.white,
      title: "تنبيه",
      middleText: "هل تريد الخروج من التطبيق",
      actions: [
        ElevatedButton(onPressed: (){
          exit(0);
        }, child: Text("Confirm")),
        ElevatedButton(onPressed: (){
          Get.back();
        }, child: Text("Cancel")),
      ] 
      
    );
    
   // return Future.value(true);
  } */