import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Model/my_fav.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class MyFavOfFunction{
  SharedPreferences _sharedPreferences;
  String _id;

  Future<List<MyFavs>> myFav() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _id = _sharedPreferences.getString("id");

    var response = await http.get("http://www.whentimee.com/sec/event/myFavsEvent/$_id");
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => MyFavs.fromJson(e))
          .toList();
    } else {

      throw Exception("Beklenmedik bir hata oluştu lütfen tekrar deneyiniz");
    }
  }
}