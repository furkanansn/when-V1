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
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Fav/FavDelete.dart';
import 'package:when/Model/event_new.dart';
import 'package:when/Model/my_fav.dart';
import 'package:when/Model/push.dart';
import 'package:when/detail_post_widget/altdetail.dart';
import 'package:when/detail_post_widget/detail_post_widget.dart';
import 'package:when/profile_widget/profile.dart';

import 'package:when/progress_bar/progress_bar.dart';
import 'package:when/settings_widget/settings.dart';
import 'package:when/values/values.dart';
import 'package:when/Fav/FavPost.dart';
class AnotherFav extends StatefulWidget {
  String _id;
  String _name;
  AnotherFav(this._id,this._name);

  @override
  _AnotherFavState createState() => _AnotherFavState(_id,_name);
}

class _AnotherFavState extends State<AnotherFav> {
  String _id;
  String name;
  _AnotherFavState(this._id,this.name);

  String profileUrl;
  FavDelete _favDelete = new FavDelete();
  Future<List<MyFavs>> myFav() async {


    var response = await http.get("http://www.whentimee.com/sec/event/myFavsEvent/$_id");
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => MyFavs.fromJson(e))
          .toList();
    } else {

      throw Exception("Beklenmedik bir hata oluştu lütfen tekrar deneyiniz");
    }
  }


///////////buraya list tile ile kullanıcıları listele zaman kalırsa kullanıcı profillerini de göster. belki de arkaş ekleme;)

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Text(
            "<",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Hiragino Maru Gothic ProN",
              fontWeight: FontWeight.w400,
              fontSize: 30,
            ),
          ),
        ),
        title:Icon(Icons.favorite, size: 40,color: AppColors.secondaryText,),
        centerTitle: false,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(top: 10),
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
        decoration: BoxDecoration(

        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(child: Text("$name Adlı Kullanıcının Favorileri")),
          Expanded(

              child: Container(
                margin: EdgeInsets.only(left: 9, top: 5, right: 11, bottom: 1),
                child: FutureBuilder(
                  future: myFav(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MyFavs>> snapshot) {
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

                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Row(
                                          children: <Widget>[
                                            new Container(
                                              alignment: Alignment.bottomLeft,
                                              child: new Text(
                                                all[index].eventHangout,style: TextStyle(color: Color.fromARGB(255, 100, 210, 255)),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(

                                    child: new Row(
                                      children: <Widget>[
                                        new Row(
                                          children: <Widget>[
                                            Center(

                                              child: new Container(
                                                width:  MediaQuery.of(context).size.width * 0.945 ,
                                                // margin: EdgeInsets.only(left: 10),
                                                alignment: Alignment.bottomCenter,
                                                child: InkWell(
                                                  onTap:() => Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext context) => AltDetail(all,index)
                                                      )
                                                  ),
                                                  child: Hero(
                                                    tag: "detail-hero"+all[index].eventPhoto.toString(),
                                                    child: new Image.network(
                                                      all[index].eventPhoto,
                                                      fit: BoxFit.fill,

                                                      height:  MediaQuery.of(context).size.height * 0.4,
                                                      width: MediaQuery.of(context).size.width * 0.945 ,
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),

                                  ),


                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        new Column(
                                          children: <Widget>[
                                            new Container(
                                              alignment: Alignment.bottomLeft,
                                              child: new Text(
                                                  all[index].eventEventName,style: TextStyle(color: Color.fromARGB(255, 100, 210, 255))

                                              ),
                                            ),
                                            new Container(
                                              alignment: Alignment.bottomLeft,
                                              child: new Text(
                                                all[index].eventEventDate.toIso8601String().substring(0,16),
                                                style: TextStyle(

                                                    fontSize: 12.0),
                                              ),
                                            ),


                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                  Divider(height: 30,),
                                  new Container(
                                    margin: EdgeInsets.only(right: 10),
                                    alignment: Alignment.bottomRight,
                                  ),
                                ],

                              ),

                            );
                          });
                    }
                    if(snapshot.data == null){
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
                                " Şimdilik $name Adlı Kullanıcının Favorileri Boş :( ",
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
                    }
                    else {
                      return Center(
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image.asset("images/wsn.png",width: 50,height: 50,),

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
              )
          ),
        ]),
      ),
    );
  }
}


