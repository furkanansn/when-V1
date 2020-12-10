import 'package:flutter/material.dart';
import 'package:when/theme/theme.dart';

import 'change_theme.dart';

class ThemeScreen extends StatefulWidget {
  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 150,
                child: RaisedButton(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                  ),
                  onPressed: () {
                    _changeTheme(context, MyThemeKeys.LIGHT);
                  },
                  child: Text("Gündüz Modu"),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 150,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                  ),
                  onPressed: () {
                    _changeTheme(context, MyThemeKeys.DARK);
                  },
                  child: Text("Gece Modu"),
                ),
              ),
            ],
          ),

          Divider(
            height: 50,
          ),
          AnimatedContainer(
            child: Image.asset(
              'images/ws.png',
              width: 90.0,
              fit: BoxFit.fitHeight,
            ),
            duration: Duration(milliseconds: 500),
            color: Theme.of(context).accentColor,
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
        ],
      ),
    );
  }
}
