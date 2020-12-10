/*
*  sign_in_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Model/User.dart';
import 'package:when/progress_bar/progress_bar.dart';
import 'package:when/sign_up_widget/sign_up_widget.dart';
import 'package:when/values/values.dart';


import '../tab_group_two_tab_bar_widget/tab_group_two_tab_bar_widget.dart';


class SignInWidget extends StatefulWidget {

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  SharedPreferences _prefs ;
  String _id;
  String _pp;
  String _usernameInput;
  bool _status;

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
  authenticate(String email, String pass) async {
    String myurl =
        "http://www.whentimee.com/sec/user/login";
    http.post(myurl, headers: {
      'Accept': 'application/json',

    }, body: {
      "user_username": email,
      "user_password": pass
    }).then((response) async {
      if(response.statusCode == 200){
        _id = User.fromJson(json.decode(response.body)).userId;
        _pp = User.fromJson(json.decode(response.body)).userPp;
        _status = User.fromJson(json.decode(response.body)).status;


      }

      if(_id != null){
        showToast("Giriş Başarılı");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            TabGroupTwoTabBarWidget()), (Route<dynamic> route) => false);
      }

      if(_status == false){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            errorPage(context)), (Route<dynamic> route) => false);
       
      }
      print(response.statusCode);
      print(response.body);
      _prefs = await SharedPreferences.getInstance();
      _prefs.setString("id",  User.fromJson(json.decode(response.body)).userId);
      _prefs.setString("pp", User.fromJson(json.decode(response.body)).userPp);
      // ignore: deprecated_member_use
      _prefs.commit();

    });
  }

  write() async{
    _prefs = await SharedPreferences.getInstance();
      _prefs.setString("id", _id);
      _prefs.setString("pp", _pp);
      // ignore: deprecated_member_use
      _prefs.commit();

  }


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

  }




@override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(

          ),
         child: SingleChildScrollView(

           padding: const EdgeInsets.all(8.0),
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 SizedBox(height: 80,),

                 Image.asset("images/ws.png",width: 250,height: 150,),
                 SizedBox(
                   height: 20,
                 ),

                 Container(
                   width: 280,
                   height: 32,
                   margin: EdgeInsets.only(top: 10),
                   decoration: BoxDecoration(
                     border: Border.fromBorderSide(Borders.primaryBorder),
                     borderRadius: BorderRadius.all(Radius.circular(13.5)),
                   ),
                   child: TextField(
                       textAlign: TextAlign.center,

                     decoration: InputDecoration(

                         contentPadding: EdgeInsets.all(5.0),
                       hintText: "Kullanıcı Adı Giriniz",
                         border: OutlineInputBorder(
                           borderRadius: const BorderRadius.all(Radius.circular(13.5)),
                           borderSide: Borders.primaryBorder,
                         )

                     ),
                     controller: _usernameController,
                     style: TextStyle(

                       fontWeight: FontWeight.w400,
                       fontSize: 12,
                     ),
                     maxLines: 1,
                     autocorrect: false,
                   ),
                 ),

                 SizedBox(
                   height: 30,
                 ),
                 Container(
                   width: 280,
                   height: 32,
                   margin: EdgeInsets.only(top: 10),
                   decoration: BoxDecoration(
                     border: Border.fromBorderSide(Borders.primaryBorder),
                     borderRadius: BorderRadius.all(Radius.circular(13.5)),
                   ),
                   child: TextField(
                     textAlign: TextAlign.center,

                     decoration: InputDecoration(
                         contentPadding: EdgeInsets.all(5.0),

                         hintText: "Parola Giriniz",
                         border: OutlineInputBorder(
                           borderRadius: const BorderRadius.all(Radius.circular(13.5)),
                           borderSide: Borders.primaryBorder,
                         )

                     ),
                     controller: _passwordController,
                     style: TextStyle(
                       fontWeight: FontWeight.w400,
                       fontSize: 12,
                     ),
                     maxLines: 1,
                     autocorrect: false,
                     obscureText: true,

                   ),
                 ),



                 SizedBox(
                   height: 20,
                 ),
                 Container(
                   width: 205,
                   height: 37,
                   margin: EdgeInsets.only(top: 68),
                   child: FlatButton(
                     onPressed: () {

                         _usernameInput = _usernameController.text;
                        authenticate(_usernameController.text, _passwordController.text) ;








                     },
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(11)),
                     ),

                     padding: EdgeInsets.all(0),
                     child: Text(
                       "Giriş Yap",
                       textAlign: TextAlign.left,
                       style: TextStyle(
                         fontFamily: "Hiragino Maru Gothic ProN",
                         fontWeight: FontWeight.w600,
                         fontSize: 25,
                         color: AppColors.secondaryText
                       ),
                     ),
                   ),
                 ),

                 SizedBox(height: 40,),


                 Center(
                   child: FlatButton(
                     onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => SignUpWidget() )),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.all(Radius.circular(0)),
                     ),
                     padding: EdgeInsets.all(0),
                     child: Text(
                       "Kayıt Ol",
                       textAlign: TextAlign.left,
                       style: TextStyle(
                         fontFamily: "Hiragino Maru Gothic ProN",
                         fontWeight: FontWeight.w800,
                         fontSize: 30,

                       ),
                     ),
                   ),
                 )

               ],
             ),
           ),
         ) ,
        ),

    );
  }
}

Widget errorPage(BuildContext context)
{
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20.0)), //this right here
    child: Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Yanlış Kullanıcı Adı Veya Parola Girdiniz",
            ),

            SizedBox(
              width: 320.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      SignInWidget()), (Route<dynamic> route) => false);
                },
                child: Text(
                  "Tamam",
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}