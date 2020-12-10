/*
*  sign_up_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:when/Model/User.dart';
import 'package:when/progress_bar/progress_bar.dart';
import 'package:when/sign_in_widget/sign_in_widget.dart';
import 'package:when/Model/error.dart';
import 'package:when/tab_group_two_tab_bar_widget/tab_group_two_tab_bar_widget.dart';
import '../values/borders.dart';
import '../values/colors.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();
  TextEditingController _nameSurnameController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  Future<User> _waiter;
  String error;
  bool status = true;
  bool _showError = false;
  bool _passwordMatch = true;
  bool _userName = true;
  bool _userFullName = true;
  bool _password = true;
  bool _email = true;
  String _userNameErr;
  String _userNameFullErr;
  String _emailErr;
  String _passwordErr;

  SharedPreferences _prefs ;

  Future navigateToSubPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignInWidget()));
  }
  Future<String> getTextFromFile() async {
    return await showError(error);
  }

/*  _SignUpWidgetState(){
    getTextFromFile().then((val) => setState(() {
      error = val;
    }));
}*/

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

  Future showError(String message) async{
    if(status == false){
      error = message.toString();
      if(message.contains("Kullanıcı Adı")){
        _userName = false;
      }
      if(message.contains("Kullan\u0131c\u0131 tam ad\u0131 bo\u015f b\u0131rak\u0131lamaz!")){
        _userFullName = false;
      }
      if(message.contains("Parola")){
        _password = false;
      }
      if(message.contains("E-posta")){
        _email = false;
      }
      showToast(error);

    }
    else
      {


         Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  TabGroupTwoTabBarWidget()), (Route<dynamic> route) => false);
        }



  }
  Future<User> signUpNet(String name, String username, String email, String password) async {
    String myurl = "http://www.whentimee.com/sec/user/addUser";
    http.post(myurl, headers: {
      'Accept': 'application/json',
    }, body: {
      "user_fullName": name,
      "user_username": username,
      "user_email": email,
      "user_password": password,
      "user_roleID": "1",
      "user_device": "android"
    }).then((response) async {
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        //navigateToSubPage(context);
        error = Error.fromJson(json.decode(response.body)).errMsg;
        status = Error.fromJson(json.decode(response.body)).status;
        showError(error);
      }
      else{
        error = Error.fromJson(json.decode(response.body)).errMsg;
        status = Error.fromJson(json.decode(response.body)).status;
        showError(error);

      }
      if(User.fromJson(json.decode(response.body)).userId != null) {
        _prefs = await SharedPreferences.getInstance();
        _prefs.setString("id", User
            .fromJson(json.decode(response.body))
            .userId);
        _prefs.setString("pp", User
            .fromJson(json.decode(response.body))
            .userPp);
        // ignore: deprecated_member_use
        _prefs.commit();
      }
    });
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _passwordAgainController = TextEditingController();

    _usernameController.addListener(_printLatestValue);
    _passwordController.addListener(_printLatestValue);
    _emailController.addListener(_printLatestValue);
    _passwordAgainController.addListener(_printLatestValue);


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _passwordAgainController.dispose();
  }
  String _fullnameCont;
  String _usernameCont;
  String _emailCont;
  String _passwordCont;
  String _passwordAgain;

  _printLatestValue() {
    _usernameCont = _usernameController.text;
    _emailCont = _emailController.text;
    _passwordCont = _passwordController.text;
    _passwordAgain = _passwordAgainController.text;
    _fullnameCont = _nameSurnameController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(

        ),
        child:
            SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80,),

                      Image.asset("images/ws.png",width: 250,height: 150,),

                      SizedBox(
                        height: 15,
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
                              hintText: "Kullanıcı Tam Adı Giriniz",
                              fillColor: AppColors.primaryElement,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(13.5)),
                                borderSide: Borders.primaryBorder,
                              )),
                          controller: _nameSurnameController,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                              fillColor: AppColors.primaryElement,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(13.5)),
                                borderSide: Borders.primaryBorder,
                              )),
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
                        height: 15,
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
                              hintText: "Email Giriniz",
                              fillColor: AppColors.primaryElement,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(13.5)),
                                borderSide: Borders.primaryBorder,
                              )),
                          controller: _emailController,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                              fillColor: AppColors.primaryElement,
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(13.5)),
                                borderSide: Borders.primaryBorder,
                              )),
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
                        height: 15,
                      ),
                      Container(

                        width: 280,
                        height: 32,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.fromBorderSide(Borders.primaryBorder),
                          borderRadius: BorderRadius.all(Radius.circular(13.5)),
                        ),
                        child: SizedBox(
                          height: 32,
                          child: TextField(
                            onChanged: (value){
                              if(_passwordController.text != _passwordAgainController.text){
                                _passwordMatch = false;
                              }
                              else{
                                _passwordMatch = true;
                              }
                              setState(() {

                              });
                            },

                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(height: 0,fontSize: 15),
                              errorText: _passwordMatch == true ?  null : "Parolalar Eşleşmedi",
                                contentPadding: EdgeInsets.all(5.0),
                                hintText: "Parolanızı Tekrar Giriniz",
                                fillColor: AppColors.primaryElement,
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(13.5)),
                                  borderSide: Borders.primaryBorder,
                                )),
                            controller: _passwordAgainController,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            autocorrect: false,
                            obscureText: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 205,
                        height: 43,
                        margin: EdgeInsets.only(bottom: 69),
                        child: FlatButton(
                          onPressed: () {
                            if (_passwordCont == _passwordAgain ) {
                              print("doğru");

                                _waiter = signUpNet(
                                    _nameSurnameController.text,
                                    _usernameController.text,
                                    _emailController.text,
                                    _passwordAgainController.text);

                            } else {
                              print("yanlış");

                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  Popup()), (Route<dynamic> route) => false);
                            }
                            return CircularProgressIndicator();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                          ),
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Kayıt Ol",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Hiragino Maru Gothic ProN",
                              fontWeight: FontWeight.w400,
                              fontSize: 28,
                              color: AppColors.secondaryText
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )

      ),
    );
  }
}

class Popup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Dialog(
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
                "Parolalar Eşleşmiyor",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                width: 320.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        SignUpWidget()), (Route<dynamic> route) => false);

                  },
                  child: Text(
                    "Tamam",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color(0xFF1BC0C5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ShowError extends StatelessWidget {
  String message;

  ShowError(this.message);

  @override
  Widget build(BuildContext context) {
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
                message,
                style: TextStyle(color: Colors.red),
              ),

              SizedBox(
                width: 320.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => SignUpWidget()));
                  },
                  child: Text(
                    "Tamam",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: const Color(0xFF1BC0C5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
