/*
*  house_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Fav/FavDelete.dart';
import 'package:when/Model/event_fav.dart';
import 'package:when/Model/event_new.dart';
import 'package:when/Model/push.dart';
import 'package:when/detail_post_widget/detail_post_widget.dart';
import 'package:when/profile_widget/another_profile.dart';
import 'package:when/profile_widget/profile.dart';

import 'package:when/progress_bar/progress_bar.dart';
import 'package:when/settings_widget/settings.dart';
import 'package:when/values/values.dart';
import 'package:when/Fav/FavPost.dart';

class FavEventWho extends StatefulWidget {
  String eventId;

  FavEventWho(this.eventId);

  @override
  _FavEventWhoState createState() => _FavEventWhoState(eventId);
}

class _FavEventWhoState extends State<FavEventWho> {
  SharedPreferences _sharedPreferences;
  String _id;
  String _eventId;

  _FavEventWhoState(this._eventId);

  Future<List<GetWhoFavsEvent>> _getFavEventWho() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _id = _sharedPreferences.getString("id");
    var response = await http.get(
        "http://www.whentimee.com/sec/event/getWhoFavsEvent/$_id-$_eventId");
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => GetWhoFavsEvent.fromJson(e))
          .toList();
    } else {
      throw Exception("Beklenmedik bir hata oluştu lütfen tekrar deneyiniz");
    }
  }

  void showToast(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
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
          ),
        ],
        centerTitle: false,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(top: 20),
          title: Image.asset(
            "images/wsn.png",
            width: 50,
            height: 50,
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 9, top: 5, right: 11, bottom: 1),
            child: FutureBuilder(
              future: _getFavEventWho(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<GetWhoFavsEvent>> snapshot) {
                if (snapshot.hasData) {
                  var all = snapshot.data;
                  return ListView.builder(
                      itemCount: all.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: new Column(
                            children: <Widget>[
                              /* Container(
                                    child: Image.network(
                                      all[index].eventPhoto
                                      ,
                                      fit: BoxFit.fill,
                                      height: 240,
                                    ),
                                  ),*/

                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => AnotherProfile(
                                              all[index].userId)));
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: ClipOval(
                                    child: Image.network(
                                      all[index].userPp,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  title: Text(all[index].userUsername),
                                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                  subtitle: Row(
                                    children: <Widget>[
                                      Text(
                                        all[index].userFullName,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                height: 30,
                              ),
                              new Container(
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.bottomRight,
                              ),
                            ],
                          ),
                        );
                      });
                }
                if (snapshot.data == null) {
                  return Center(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: new BoxDecoration(
                              border: new Border.all(),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: new Text(
                            "Bu Etkinliği Şimdilik Favorilerine Ekleyen Kişi Yok",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        new Text(""),
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
                } else {
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
              },
            ),
          )),
        ]),
      ),
    );
  }
}
