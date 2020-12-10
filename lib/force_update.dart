/*
*  cell_two_item_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:when/values/colors.dart';
import 'package:url_launcher/url_launcher.dart';


class ForceUpdate extends StatelessWidget {
  String header;
  String message;
  String updateLink;


  ForceUpdate(this.header, this.message,this.updateLink);

  @override
  Widget build(BuildContext context) {

    return ana(header,message,updateLink);

  }
}

Widget ana(String header,String message,String updateLink){

  return Scaffold(
    body: Center(
      child: Container(
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 13, 20, 24),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.info, size: 80,color: AppColors.secondaryText,)
            ),
            Text(
              header,
              style: TextStyle(fontSize: 30,color: AppColors.secondaryText,fontWeight:FontWeight.w800 ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 45,),
            Text(
              message,
              style: TextStyle(fontSize: 24,color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
            ),
            Container(
                color: AppColors.secondaryText,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.store),
                  ),
                  title:
                  Center(child: Text("Güncelle", style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500,fontSize: 35))),
                  subtitle: Text(""),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    if (await canLaunch(updateLink)) {
                      await launch(updateLink);
                    } else {
                      throw "Can't phone that number.";
                    }
                  },
                )),
            SizedBox(height: 20,),
            Image.asset(
              "images/ws.png",
              width: 300,
              height: 50,
            ),

          ],
        ),
      ),
    ),

    drawer: Drawer(
      child:
    Image.asset(
      "images/w.png",
      width: 50,
      height: 50,
    ),


  ),



  );
}
