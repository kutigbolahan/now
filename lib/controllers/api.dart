import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;




class CallApi with ChangeNotifier{
  final String baseURL ='https://empl-dev.site/api/';
 // https://empl-dev.site/api/user/user_registration

 Future postData(data,apiUrl)async{
    try {
       var fullUrl = baseURL + apiUrl;
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders()
     
    );
    
    } catch (e) {
    
    }
   
    
  }

  getData(apiUrl)async{
   var fullUrl = baseURL + apiUrl;
   return await http.get(
     fullUrl,
     headers: _setHeaders()
   );
  }
  _setHeaders()=> {
    'Content-type':'application/json',
    'Accept' : 'application/json',
  };

  

}


