/*
*  main.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Model/push.dart';
import 'package:when/force_update.dart';
import 'package:when/intro_widget/intro.dart';
import 'package:when/profile_widget/EditMyProfile.dart';
import 'package:when/profile_widget/another_profile.dart';
import 'package:when/profile_widget/profile.dart';
import 'package:when/theme/change_theme.dart';
import 'package:when/theme/change_theme_widget.dart';
import 'package:when/theme/theme.dart';
import 'sign_in_widget/sign_in_widget.dart';
import 'tab_group_two_tab_bar_widget/tab_group_two_tab_bar_widget.dart';
import 'package:package_info/package_info.dart';
import 'dart:io' show Platform;

main()  {

  runApp(
    CustomTheme(
      initialThemeKey: MyThemeKeys.LIGHT,
      child: App(),
    ),
  );
}

class App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: CustomTheme.of(context),
            home:  Splash(),
          );

  }
}


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool ads = false;
  String _header;
  String _message;
  String _updateLinkIos = "https://apps.apple.com/us/app/id1524444106";
  String _updateLinkAnd = "https://play.google.com/store/apps/details?id=com.HobedTech.when";
  bool isIos = false;
  bool isAnd = false;
  getVersion(String andVersionName, String andVersionCode,String iosVersionName,String iosVersionCode,String header, String message, BuildContext buildContext) async {

              if(Platform.isIOS ){
                PackageInfo packageInfo = await PackageInfo.fromPlatform();
                String versionName = packageInfo.version;
                String versionCode = packageInfo.buildNumber;
                _header = header;
                _message = message;
                isIos = true;
                if(int.parse(versionCode) < int.parse(iosVersionCode)){
ads = true;

              }
                else{
                  ads =false;
                }
  }
              if(Platform.isAndroid){
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  String versionName = packageInfo.version;
                  String versionCode = packageInfo.buildNumber;
                  _header = header;
                  _message = message;
                  isAnd = true;
                  print(versionCode);
                  print(andVersionCode);
                  if(versionCode != andVersionCode){
ads = true;
                  }else{
                    ads=false;
                  }

                }

}

                  Future<bool> pushNot() async {
                    var response = await http.get("http://whentimee.com/push");
                    if (response.statusCode == 200) {
                      if(response.body.isNotEmpty) {
                        getVersion(Push.fromJson(jsonDecode(response.body)[0]).andVersionName,
                            Push.fromJson(jsonDecode(response.body)[0]).andVersionCode,
                            Push.fromJson(jsonDecode(response.body)[0]).iosVersionName,
                            Push.fromJson(jsonDecode(response.body)[0]).iosVersionCode,
                            Push.fromJson(jsonDecode(response.body)[0]).header,
                            Push.fromJson(jsonDecode(response.body)[0]).message,
                          context,

                        );

                        return false;
                      }

                    }

                  }

  SharedPreferences _prefs;
  String id;
  String intro;
  @override
  void initState() {

    pushNot();

    Future.delayed(const Duration(seconds: 1), () async {
      if(ads == true){
        if(isIos == true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  ForceUpdate(_header, _message, _updateLinkIos)), (
              Route<dynamic> route) => false);
        }
        else{
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  ForceUpdate(_header, _message, _updateLinkAnd)), (
              Route<dynamic> route) => false);
        }

      }
      else{
        _prefs = await SharedPreferences.getInstance();
        id = _prefs.getString("id");
        intro = _prefs.getString("intro");
        if(intro == null){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              Intro()), (Route<dynamic> route) => false);
        }
        if(intro != null){
          if(id == null){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                SignInWidget()), (Route<dynamic> route) => false);
          }
          else{
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                TabGroupTwoTabBarWidget()), (Route<dynamic> route) => false);
          }
        }
      }




    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 20, 24),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset("images/ws.png",width: 250,height: 250,),
            //Image.asset('assets/images/flutterlogo.png', width: 40, height: 40,),
            SizedBox(
              height: 25,
            ),

          ],
        ),
      ),
    );
  }
}

