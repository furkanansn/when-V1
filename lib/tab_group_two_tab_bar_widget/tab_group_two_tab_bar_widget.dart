/*
*  tab_group_two_tab_bar_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:when/Model/User.dart';
import 'package:when/discover_widget/discover_widget.dart';
import 'package:when/house_widget/house_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:when/settings_widget/settings.dart';
import 'package:when/values/colors.dart';

class TabGroupTwoTabBarWidget extends StatefulWidget {





  
  @override
  State<StatefulWidget> createState() => _TabGroupTwoTabBarWidgetState();
}


class _TabGroupTwoTabBarWidgetState extends State<TabGroupTwoTabBarWidget> {
  List<Widget> _tabWidgets = [
    HouseWidget(),
    DiscoverWidget(),
    SettingsWidget(),
  ];
  int _currentIndex = 0;
  
  void _onTabChanged(int index) => this.setState(() => _currentIndex = index);
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: _tabWidgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(

        elevation: 1,
        iconSize: 35,
        currentIndex: _currentIndex,
        onTap: (index) => this._onTabChanged(index),
        items: [
          BottomNavigationBarItem(
            title: Text(
              "",
              textAlign: TextAlign.left,
              style: TextStyle(

                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            icon: Icon(CupertinoIcons.home),
            activeIcon: Icon(CupertinoIcons.home,color: Color.fromARGB(255, 100, 210, 255)),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.up_arrow),
            activeIcon: Icon(CupertinoIcons.up_arrow,color: Color.fromARGB(255, 100, 210, 255)),
            title: Text(
              "",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            activeIcon: Icon(CupertinoIcons.settings,color: Color.fromARGB(255, 100, 210, 255)),
            title: Text(
              "",
              textAlign: TextAlign.left,
              style: TextStyle(

                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}