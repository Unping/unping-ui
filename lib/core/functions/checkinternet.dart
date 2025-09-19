// This function checks the internet connection by trying to look up "google.com".  
// If the lookup succeeds and returns a valid address, it returns true (online).  
// If a SocketException occurs, it returns false (offline).

import 'dart:io';

checkInternet() async{
  try{
    var result = await InternetAddress.lookup("google.com");
    if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
      return true;
    }
    
    
  }
  on SocketException catch(_){
      return false;
    }
}