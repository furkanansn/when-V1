import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Fav/AnotherFav.dart';
import 'package:when/Fav/MyFav.dart';
import 'package:when/Model/User.dart';
import 'package:when/profile_widget/profile.dart';
import 'package:when/progress_bar/progress_bar.dart';
import 'package:when/sign_up_widget/sign_up_widget.dart';
import 'package:when/tab_group_two_tab_bar_widget/tab_group_two_tab_bar_widget.dart';
import 'package:when/values/values.dart';
import 'package:path/path.dart';

class EditMyProfile extends StatefulWidget {
  @override
  _EditMyProfileState createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  String _nameController = "Adı Soyadı";
  String _usernameController = "Kullanıcı Adı";
  String _insta;
  String _face;
  String _twitter;
  String _bio;
  String _userPhoto;
  TextEditingController _instaController;
  TextEditingController _faceController;
  TextEditingController _twitterController;
  TextEditingController _bioController;
  Future getUserById(String id) async {
    String myurl = "http://www.whentimee.com/sec/user/profile/$id";
    http.get(myurl, headers: {
      'Accept': 'application/json',
    }).then((response) async {
      if (response.statusCode == 201) {
        User.fromJson(json.decode(response.body));
      }
      _nameController = User.fromJson(json.decode(response.body)).userFullName;

      _usernameController =
          User.fromJson(json.decode(response.body)).userUsername;
      _userPhoto = User.fromJson(json.decode(response.body)).userPp;

      _face = User.fromJson(json.decode(response.body)).userFacebook;

      _insta = User.fromJson(json.decode(response.body)).userInstagram;

      _twitter = User.fromJson(json.decode(response.body)).userTwitter;

      _bio = User.fromJson(json.decode(response.body)).userAbout;

      //_prefs = await SharedPreferences.getInstance();
      // _prefs.remove("pp");
      // _prefs.setString("pp", User.fromJson(json.decode(response.body)).userPp);
    }).whenComplete(() => setState(() {}));
  }

  read() async {
    SharedPreferences _prefs;
    _prefs = await SharedPreferences.getInstance();
    String _id = _prefs.getString("id");

    getUserById(_id);
  }


  UpdateUser() async{
    String url = "";
    http.post(url,headers: {
      'Accept': 'application/json',
    },body: {

    }).then((value) async{
      if(value.statusCode ==201){

      }
    });
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

  num position = 1;
  num positionImage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    read();
    _bioController.text = _bio;
    _instaController.text = _insta;
    _faceController.text = _face;
    _twitterController.text = _twitter;
  }

  Widget _buildProfileImage(context) {
    return Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Image.network(
                _userPhoto == null
                    ? "http://www.whentimee.com//upload//user_photos//default.png"
                    : _userPhoto,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ));
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _nameController,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _usernameController,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(13.5)),
                  borderSide: Borders.primaryBorder,
                )),
            controller: _faceController,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            maxLines: 1,
            autocorrect: false,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(13.5)),
                  borderSide: Borders.primaryBorder,
                )),
            controller: _instaController,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            maxLines: 1,
            autocorrect: false,
          ),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(13.5)),
                  borderSide: Borders.primaryBorder,
                )),
            controller: _twitterController,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            maxLines: 1,
            autocorrect: false,
          ),
          //_buildStatItem(_face == null ? "-" : _face, "Facebook"),
          //_buildStatItem(_insta == null ? "-" : _insta, "Instagram"),
          //_buildStatItem(_twitter == null ? "-" : _twitter, "Twitter"),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,
      //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(

      padding: EdgeInsets.all(8.0),

        child: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Hakkında",
                    border: OutlineInputBorder(

                      borderRadius:
                      const BorderRadius.all(Radius.circular(13.5)),
                      borderSide: Borders.primaryBorder,
                    )),
                controller: _bioController,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                maxLines: 1,
                autocorrect: false,
                obscureText: true,
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: "Facebook hesabı linki",
                    border: OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(13.5)),
                      borderSide: Borders.primaryBorder,
                    )),
                controller: _faceController,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                maxLines: 1,
                autocorrect: false,
                obscureText: true,
              ),

              TextField(
                decoration: InputDecoration(
                    hintText: "Instagram hesabı linki",

                    border: OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(13.5)),
                      borderSide: Borders.primaryBorder,
                    )),
                controller: _instaController,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                maxLines: 1,
                autocorrect: false,
                obscureText: true,
              ),

              TextField(
                decoration: InputDecoration(
                    hintText: "Twitter hesabı linki",

                    border: OutlineInputBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(13.5)),
                      borderSide: Borders.primaryBorder,
                    )),
                controller: _twitterController,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                maxLines: 1,
                autocorrect: false,
                obscureText: true,
              ),
            ],
          ),
        ),


    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildButtons(context) {
    return  Container(
      child: FlatButton(
        onPressed: () {



        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        padding: EdgeInsets.all(0),
        child: Text(
          "Düzenle",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontFamily: "Hiragino Maru Gothic ProN",
            fontWeight: FontWeight.w400,
            fontSize: 48,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
      ),
      body: Stack(
        children: <Widget>[


              Column(
                children: <Widget>[
                  _buildProfileImage(context),
                  _buildFullName(),
                  _buildStatus(context),

                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  SizedBox(height: 8.0),
                  _buildButtons(context),
                ],
              ),


        ],
      ),
    );
  }
}
