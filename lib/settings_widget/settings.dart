/*
*  settings_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Fav/MyFav.dart';
import 'package:when/profile_widget/my_profile.dart';
import 'package:when/profile_widget/profile.dart';
import 'package:when/sign_in_widget/sign_in_widget.dart';
import 'package:when/theme/change_theme_widget.dart';
import 'package:when/values/values.dart';

class SettingsWidget extends StatelessWidget {
  SharedPreferences _prefs;
  exit(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.remove("id");
    _prefs.commit();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignInWidget()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ayarlar",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: "Hiragino Maru Gothic ProN",
            fontWeight: FontWeight.w400,
            fontSize: 40,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => Profile())),
                  child: Text(
                    "Profili Düzenle",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontFamily: "Hiragino Maru Gothic ProN",
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 85,
                ),
                ThemeScreen(),
                MaterialButton(onPressed: (){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => FavWhoArrived()));
                },child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.favorite),
                  ),
                  title: Center(
                    child: Text(
                      "Favorilerim",
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  ),
                ),),
                Divider(
                  height: 50,
                ),
                InkWell(
                  onTap: () => exit(context),
                  child: Text(
                    "Çıkış Yap",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontFamily: "Hiragino Maru Gothic ProN",
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
