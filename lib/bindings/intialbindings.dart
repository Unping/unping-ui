/* 
 This code defines an Initial Binding class using GetX in Flutter.
It ensures that the Crud service (which handles Create, Read, Update, and Delete operations for the database) is registered in the dependency injection system at the start of the app.
That way, the Crud instance can be easily accessed anywhere in the project without creating it manually each time.
 */
 
 
 /*import 'package:get/get.dart';
import 'package:phoinex/core/class/crud.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(Crud());  // crud(create, reade, update, delete) for database
  }

}    */