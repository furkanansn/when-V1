import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Fav/FavDelete.dart';
import 'package:when/Model/User.dart';
class Fav{
  SharedPreferences _sharedPreferences;
  String _id;
  String _status;
  bool ok;
  bool ret;

   fav(String event_id) async {
     print("deneme");
     _sharedPreferences = await SharedPreferences.getInstance();
     _id = _sharedPreferences.getString("id");
     String myurl =
         "http://www.whentimee.com/sec/event/addFavs/";
     http.post(myurl, headers: {
       'Accept': 'application/json',

     }, body: {
       "user_id": _id,
       "event_id": event_id
     }).then((response) async {
       if(response.statusCode == 200){

         _status = User.fromJson(json.decode(response.body)).status.toString();
       }
print(_status);


       if(_status == "false"){
         ret = false;
         showToast("Etkinlik günü geçtiği zaman kaldırılacaktır");
       }
       if(_status == "true"){
         ret = true;
       }

     //burda tamamlanmış olur


     });

   }



  void showToast(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white
    );
  }


 }