/*
*  cell_two_item_widget.dart
*  When
*
*  Created by Furkan Anşin.
*  Copyright © 2018 HobedTech. All rights reserved.
    */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:when/values/values.dart';
import 'package:when/detail_post_widget/detail_post_widget.dart';

class CellNoItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ana();

  }
}

Widget ana(){
  return Container(
    height: 400,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Colors.white,
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
        Text(
          "Bugün Etkinlik Bulunamadı Discover Sayfasından İleri Tarihlerdeki Etkinlikleri Görebilirsiniz",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(CupertinoIcons.info, size: 80,)
        ),

      ],
    ),
  );
}
