// This code defines a GetX service to manage shared preferences. 
// - `MyServices` wraps SharedPreferences and provides an `init` method to initialize it asynchronously.
// - `initialServices()` is a helper function to register `MyServices` with GetX using `putAsync`, 
//   ensuring that shared preferences are ready to use throughout the app.


/*
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences ;

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance() ;
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}                   */