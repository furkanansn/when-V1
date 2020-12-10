/*
*  detail_post_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:when/Fav/FavEventWho.dart';
import 'package:when/Fav/MyFav.dart';
import 'package:when/house_widget/house_widget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:when/progress_bar/progress_bar.dart';

import 'package:when/values/values.dart';

class DetailPostWidget extends StatefulWidget {
  List<dynamic> all;
  int index;

  DetailPostWidget(this.all, this.index);

  @override
  _DetailPostWidgetState createState() => _DetailPostWidgetState();
}

class _DetailPostWidgetState extends State<DetailPostWidget> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  double lat, lon;

  String url;

  num position = 1 ;

  final key = UniqueKey();



  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A){
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final partyTime = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        " Tarih:" + widget.all[widget.index].eventEventDate.toString().substring(0, 16),
        //all[index].title
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Center(
          child: Text(
            widget.all[widget.index].eventHangout,

            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Helvetica Neue",
              fontWeight: FontWeight.w400,
              fontSize: (widget.all[widget.index].eventHangout.toString().length>13) ? 20 : 30,
            ),
          ),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      //all[index].title,
                      widget.all[widget.index].eventEventName,
style:               TextStyle(color: Colors.white) ,

                    ))),
            Expanded(flex: 10, child: partyTime)
          ],
        ),
      ],
    );

    final topContent = Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 1.0,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 1.0,
            child: Hero(
                tag: "detail-hero" + widget.all[widget.index].eventPhoto.toString(),
                child: Image.network(
                  widget.all[widget.index].eventPhoto,
                  fit: BoxFit.fill,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
            child: Center(
              child: topContentText,
            ),
          ),
          Positioned(
            left: 8.0,
            top: 60.0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
    final whoButton =     MaterialButton(onPressed: (){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> FavEventWho(widget.all[widget.index].eventId)));

    },child: ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.favorite),
      ),
      title: Center(
        child: Text(
          "Bu Etkinliği Favorilerine Ekleyenler",
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
      ),
    ),);


    final progressBar =  BarProgressIndicator(
      numberOfBars: 3,
      color: Colors.grey,
      fontSize: 20.0,
      barSpacing: 2.0,
      beginTweenValue: 5.0,
      endTweenValue: 10.0,
      milliseconds: 200,
    );
    lat = double.parse(widget.all[widget.index].eventLocationX);
    lon = double.parse(widget.all[widget.index].eventLocationY);
    print(lat);
    final mapContent = SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 1.0,
      child: IndexedStack(
        index: position,
        children: [
          (widget.all[widget.index].url_iframe.toString().length > 1 ) ?

          WebView(
            onPageStarted: startLoading,
            onPageFinished: doneLoading,
            key: key,
            initialUrl: widget.all[widget.index].url_iframe,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },

          )
          :
          WebView(
            onPageStarted: startLoading,
            onPageFinished: doneLoading,
            key: key,
            initialUrl: 'https://www.google.com/maps/search/?api=1&query=$lat,$lon',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },

          ),



          progressBar
        ],
      ),
    );



    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        width: MediaQuery.of(context).size.width*0.9,
        child: RaisedButton(
          onPressed: () async {

            lat = double.parse(widget.all[widget.index].eventLocationX);
            lon = double.parse(widget.all[widget.index].eventLocationY);
            // kıbrıs 35.095192, 33.203430
             url =
                'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          color: AppColors.accentElement,
          child: Text("Adresi Haritalarda Aç",
              style: TextStyle(color: AppColors.primaryElement)),
        ));

    final callButton = Container(
        width: MediaQuery.of(context).size.width*0.7,

        color: AppColors.accentElement,
        child: ListTile(
      leading: CircleAvatar(

        child: Icon(CupertinoIcons.phone_solid),
      ),
      title:Center(
        child:  Text("Şimdi Ara", style: TextStyle(color: AppColors.primaryElement)),
      ),

      subtitle: Center(child: Text("İletişim: "+widget.all[widget.index].mobile,style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w800))),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.white,
      ),
      onTap: () async {
        String number;
        number = widget.all[widget.index].mobile;
        String telephoneUrl = "tel:$number";

        // kıbrıs 35.095192, 33.203430

        if (await canLaunch(telephoneUrl)) {
          await launch(telephoneUrl);
        } else {
          throw "Can't phone that number.";
        }
      },
    ));

    /*ListTile(

        title: Text("Telephone"),
        onTap: () async {

        });*/

    final bottomContent = Container(

      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          children: <Widget>[ readButton, callButton],
        ),
      ),
    );

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
            children: <Widget>[topContent,Container(height: 5,),mapContent,whoButton, bottomContent],
          ),
      ),
    );
  }
}
