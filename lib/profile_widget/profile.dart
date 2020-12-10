import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:when/Model/User.dart';
import 'package:when/progress_bar/progress_bar.dart';
import 'package:when/tab_group_two_tab_bar_widget/tab_group_two_tab_bar_widget.dart';
import 'package:when/values/values.dart';
import 'package:path/path.dart';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<File> imageFile;
  var _waiter;
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  setStatus(String message) {
    setState(() {
      var status = message;
    });
  }

  TextEditingController _nameController;
  TextEditingController _usernameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _passwordAgain;

  SharedPreferences _prefs;
  Future getUserById(String id) async {
    String myurl = "http://www.whentimee.com/sec/user/profile/$id";
    http.get(myurl, headers: {
      'Accept': 'application/json',
    }).then((response) async {
      if (response.statusCode == 201) {
        User.fromJson(json.decode(response.body));
      }
      _nameController.text =
          User.fromJson(json.decode(response.body)).userFullName;
      _emailController.text = User.fromJson(json.decode(response.body)).email;
      _usernameController.text =
          User.fromJson(json.decode(response.body)).userUsername;
      _passwordController.text =
          User.fromJson(json.decode(response.body)).userPassword;
      _passwordAgain.text =
          User.fromJson(json.decode(response.body)).userPassword;
      _userPhoto = User.fromJson(json.decode(response.body)).userPp;

      //_prefs = await SharedPreferences.getInstance();
      // _prefs.remove("pp");
      // _prefs.setString("pp", User.fromJson(json.decode(response.body)).userPp);
    }).whenComplete(() => setState(() {}));
  }

  read() async {
    _prefs = await SharedPreferences.getInstance();

    String id = _prefs.getString("id");
    String pp = _prefs.getString("pp");
    if (id != null) {
      //var newId = int.parse(id);

      getUserById(id);
      _idFor = id;
      _imageCont = pp;
      _prefs.commit();
    }
  }

  String _nameCont;
  String _emailCont;
  String _usernameCont;
  String _passwordCont;
  String _imageCont;
  String _idFor;
  String _userPhoto;
  var _jpeg, _png, _jpg;
  pdateUser(
      String username, String email, String password, String fileName) async {
    String myurl = "http://www.whentimee.com/sec/user/updateUser/$_idFor";
    String name;
    if (base64Image != null) {
      http.post(myurl, headers: {
        'Accept': 'application/json',
      }, body: {
        "user_fullName": _nameCont,
        "user_username": _usernameCont,
        "user_email": _emailCont,
        "user_password": _passwordCont,
        "user_PP": "data:image/png;base64," + base64Image,
        "extention": fileName,
      }).then((response) async {
        if (response.statusCode == 201) {
          User.fromJson(json.decode(response.body));
        }
        print("sadasdasdas" + fileName);

        _nameCont = User.fromJson(json.decode(response.body)).userFullName;
        _emailCont = User.fromJson(json.decode(response.body)).email;
        _usernameCont = User.fromJson(json.decode(response.body)).userUsername;
        _passwordCont = User.fromJson(json.decode(response.body)).userPassword;
        _userPhoto = User.fromJson(json.decode(response.body)).userPp;
        print(response.statusCode);
        showToast("Güncelleme Başarılı");
      });
    } else {
      http.post(myurl, headers: {
        'Accept': 'application/json',
      }, body: {
        "user_fullName": _nameCont,
        "user_username": _usernameCont,
        "user_email": _emailCont,
        "user_password": _passwordCont,
      }).then((response) async {
        if (response.statusCode == 201) {
          User.fromJson(json.decode(response.body));
        }

        _nameCont = User.fromJson(json.decode(response.body)).userFullName;
        _emailCont = User.fromJson(json.decode(response.body)).email;
        _usernameCont = User.fromJson(json.decode(response.body)).userUsername;
        _passwordCont = User.fromJson(json.decode(response.body)).userPassword;
        _userPhoto = User.fromJson(json.decode(response.body)).userPp;
        print(response.statusCode);
        showToast("Güncelleme Başarılı");
      });
    }

    if (_jpeg == true) {
      name = "jpeg";
    }
    if (_png == true) {
      name = "png";
    }
    if (_jpg == true) {
      name = "jpg";
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

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  @override
  void initState() {
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _passwordAgain = TextEditingController();
    // _usernameController.text = _getUserInfo().username;
    super.initState();
    read();
    _nameController.addListener(_printLatestValue);
    _usernameController.addListener(_printLatestValue);
    _passwordController.addListener(_printLatestValue);
    _emailController.addListener(_printLatestValue);
    _passwordAgain.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _passwordAgain.dispose();
  }

  _printLatestValue() {
    _nameCont = _nameController.text;
    _usernameCont = _usernameController.text;
    _emailCont = _emailController.text;
    _passwordCont = _passwordController.text;
  }

  num position = 1;
  num positionImage = 0;
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  doneImageLoading(String A) {
    setState(() {
      positionImage = 0;
    });
  }

  startImageLoading(String A) {
    setState(() {
      positionImage = 1;
    });
  }

  String fileName = "";
  startUpload() {
    setStatus('Profil Fotoğrafı Güncelleniyor');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    fileName = tmpFile.path.split('.').last;
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          positionImage = 1;
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                border: Border.all(
                  width: 3,
                )),
            child: Image.file(
              snapshot.data,
              width: 100,
              fit: BoxFit.contain,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Beklenmeyen bir sorunla karşılaşıldı lütfen tekrar dene',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            '',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_nameController.text.length > 3) {
      position = 0;
    } else {
      return Scaffold(
        body: Center(
          child: Column(
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
        ),
      );
    }
    if (file != null) {}
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: "Hiragino Maru Gothic ProN",
            fontWeight: FontWeight.w400,
            fontSize: 48,
          ),
        ),
        centerTitle: true,
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
        actions: <Widget>[],
      ),
      body: IndexedStack(
        index: position,
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IndexedStack(
                    index: positionImage,
                    children: [
                      new Center(
                          child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Image.network(
                              _userPhoto,
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  //      InkWell(child: CircleAvatar(child: Image.network(_userPhoto),radius: 20,)),

                  showImage(),

                  MaterialButton(
                    onPressed: () {
                      chooseImage();
                      startImageLoading("A");
                    },
                    child: Text("Profil Resmini Düzenle"),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13.5)),
                        borderSide: Borders.primaryBorder,
                      )),
                      controller: _nameController,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      autocorrect: false,
                    ),
                  ),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13.5)),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13.5)),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13.5)),
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13.5)),
                        borderSide: Borders.primaryBorder,
                      )),
                      controller: _passwordAgain,
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
                    child: FlatButton(
                      onPressed: () {
                        startUpload();

                        //_futureUser = _updateUser(_usernameController.text, _emailController.text, _passwordController.text);
                        _waiter = pdateUser(
                            _usernameController.text,
                            _emailController.text,
                            _passwordController.text,
                            fileName);
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
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
