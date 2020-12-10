/*
*  house_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Model/User.dart';
import 'package:when/Model/event_new.dart';
import 'package:when/house_widget/cell_no_item_widget.dart';
import 'package:when/profile_widget/profile.dart';
import 'package:when/progress_bar/progress_bar.dart';
import 'package:when/settings_widget/settings.dart';
import 'package:when/values/values.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'cell_two_item_widget.dart';

class HouseWidget extends StatefulWidget {
  @override
  _HouseWidgetState createState() => _HouseWidgetState();
}

class _HouseWidgetState extends State<HouseWidget> {

  SharedPreferences _prefs;
  String urlPhoto;
  List _all;
  Future<List<EventNew>> _getHouseItems() async {
    var response = await http.get("http://whentimee.com/sec/event/today");
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => EventNew.fromJson(e))
          .toList();
    } else {
      throw Exception("Beklenmedik bir hata oluştu lütfen tekrar deneyiniz");
    }

  }







  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Günün Etkinlikleri",
              style: TextStyle(

                fontFamily: "Hiragino Maru Gothic ProN",
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
        ],

        title: Text(
          "HOME",
          style: TextStyle(
            color: AppColors.secondaryText,
            fontFamily: "Hiragino Maru Gothic ProN",
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
        centerTitle: false,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(top: 20),
          title: Image.asset(
            "images/w.png",
            width: 50,
            height: 50,
          ),
          
          centerTitle: true,
        ),

      ),

      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(

          ),
          child: Stack(

            children: [


              Center (
                child: Stack(

                  alignment: Alignment.center,
                  children: [

                    Center(

                      child: FutureBuilder(
                        future: _getHouseItems(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<EventNew>> snapshot) {
                          if (snapshot.hasData) {
                             _all = snapshot.data;
                              return ListView.builder(
                                  itemCount: _all.length,
                                  itemBuilder: (context, index) =>
                                      CellTwoItemWidget(_all, index));
                          }

                          else {
                            if(snapshot.hasError){
                              return CellNoItemWidget();
                            }else {
                              return Center(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Image.asset(
                                      "images/wsn.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                    BarProgressIndicator(
                                      numberOfBars: 4,
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                      barSpacing: 2.0,
                                      beginTweenValue: 5.0,
                                      endTweenValue: 10.0,
                                      milliseconds: 200,
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
/**/


