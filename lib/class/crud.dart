/*
This code defines a Crud class that handles HTTP POST requests in Flutter.

It first checks if the device is connected to the internet.

If online, it sends a POST request to the given URL with the provided data.

If the response status is 200 or 201, it decodes the JSON response and returns it wrapped in Right.

If the server fails, it returns a Left with serverfailure.

If there is no internet, it returns a Left with offlinefailure.

The function uses the Either type from the dartz package to handle both success (Right) and failure (Left) cases in a clean way.
*/


/*
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:phoinex/core/class/statudrequest.dart';
import 'package:phoinex/core/functions/checkinternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl,Map data) async{
 //   try{
         if (await checkInternet()){
     var response = await http.post(Uri.parse(linkurl) ,body: data);
     if(response.statusCode == 200 || response.statusCode == 201){
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
     }
     else{
      return Left(StatusRequest.serverfailure) ;
     }
    }
    else{
      return const Left(StatusRequest.offlinefailure);
    }
 //   }
   // catch(_){
     // return Left(StatusRequest.serverException);
    //}
  }
}  */