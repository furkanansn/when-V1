
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Fav/FavDelete.dart';
import 'package:when/Fav/MyFav.dart';
import 'package:when/Fav/my_fav_function.dart';
import 'package:when/Model/event_new.dart';
import 'package:when/Model/my_fav.dart';
import 'package:when/Model/push.dart';
import 'package:when/detail_post_widget/detail_post_widget.dart';
import 'package:when/profile_widget/profile.dart';

import 'package:when/progress_bar/progress_bar.dart';
import 'package:when/settings_widget/settings.dart';
import 'package:when/values/values.dart';
import 'package:when/Fav/FavPost.dart';
class DiscoverArrived extends StatefulWidget {
  @override
  _DiscoverArrivedState createState() => _DiscoverArrivedState();
}

class _DiscoverArrivedState extends State<DiscoverArrived> {
  int i = 0;
  SharedPreferences _prefs;
  String profileUrl;
  List favLocal = new List();
  Fav _fav = new Fav();
  FavDelete _favDelete = new FavDelete();
  bool fav_icon = false;
  List<MyFavs> favs;
  MyFavOfFunction myFavOfFunction = new MyFavOfFunction();
  MyFavs myFavs;
  Future<List<EventNew>> _getDiscoverItems() async {
    favs = await myFavOfFunction.myFav();
    favLocal = favs;
    var response = await http.get("http://www.whentimee.com/sec/event/getAll");
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
              "İleri Tarihli Etkinlikler",
              style: TextStyle(
                fontFamily: "Hiragino Maru Gothic ProN",
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ),
        ],

        title: Text(
          "DISCOVER",
          style: TextStyle(
            color: AppColors.secondaryText,
            fontFamily: "Hiragino Maru Gothic ProN",
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
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
        decoration: BoxDecoration(

        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(

            child: Container(
                margin: EdgeInsets.only(left: 9, top: 5, right: 11, bottom: 1),
                child: FutureBuilder(
                  future: _getDiscoverItems(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<EventNew>> snapshot) {
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
                                                          builder: (BuildContext context) => DetailPostWidget(all,index)
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
                                                all[index].eventEventDate.substring(0,16),
                                                style: TextStyle(

                                                    fontSize: 12.0),
                                              ),
                                            ),


                                          ],
                                        ),
                                        (favLocal.length < 1) ?
                                        InkWell(

                                          onTap: (){
                                            _fav.fav(all[index].eventId);

                                            setState(() {
                                              // _getDiscoverItems.call();
                                              int len = favs.length - 1;
                                              favLocal[len].eventId =
                                                  all[index].eventId;
                                            });



                                          },


                                          child: new Icon(
                                           Icons.favorite_border,
                                            //  Icons.favorite_border,
                                            color: AppColors.secondaryText,
                                          ),
                                        ):
                                        InkWell(

                                          onTap: (){
                                            _fav.fav(all[index].eventId);

                                              setState(() {
                                                // _getDiscoverItems.call();
                                                int len = favLocal.length - 1;
                                                favLocal[len].eventId =
                                                    all[index].eventId;
                                              });



                                          },


                                          child: new Icon(
                                            favLocal.firstWhere((e) => e.eventId == all[index].eventId, orElse: () => null) != null  ? Icons.favorite : Icons.favorite_border,
                                          //  Icons.favorite_border,
                                            color: AppColors.secondaryText,
                                          ),
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
                    } else {
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

class DiscoverWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (DiscoverArrived()),
      ),
    );
  }
}
